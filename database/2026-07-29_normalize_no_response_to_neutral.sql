
DECLARE @DryRun BIT = 1;

BEGIN TRANSACTION;

DECLARE @FisherNeutralID INT;
DECLARE @FisherNeutralSortOrder INT;
DECLARE @VesselNeutralID INT;
DECLARE @VesselNeutralSortOrder INT;

UPDATE dbo.TLU_FisherResponseToCetacean
SET [Desc] = 'Neutral'
WHERE active = 1
  AND LOWER(LTRIM(RTRIM([Desc]))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
  AND LOWER(LTRIM(RTRIM([Desc]))) COLLATE DATABASE_DEFAULT <> 'neutral';

;WITH VesselNoResponseTarget AS (
    SELECT TOP (1) ID
    FROM dbo.TLU_VesselResponseToCetacean
    WHERE active = 1
      AND LOWER(LTRIM(RTRIM([Desc]))) COLLATE DATABASE_DEFAULT = 'no response'
    ORDER BY ISNULL(SortOrder, ID), ID
)
UPDATE vessel
SET vessel.[Desc] = 'Neutral'
FROM dbo.TLU_VesselResponseToCetacean vessel
INNER JOIN VesselNoResponseTarget target
    ON target.ID = vessel.ID
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.TLU_VesselResponseToCetacean existingNeutral
    WHERE existingNeutral.active = 1
      AND LOWER(LTRIM(RTRIM(existingNeutral.[Desc]))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
);

SELECT TOP 1
    @FisherNeutralID = ID,
    @FisherNeutralSortOrder = ISNULL(SortOrder, ID)
FROM dbo.TLU_FisherResponseToCetacean
WHERE active = 1
  AND LOWER(LTRIM(RTRIM([Desc]))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
ORDER BY ISNULL(SortOrder, ID), ID;

SELECT TOP 1
    @VesselNeutralID = ID,
    @VesselNeutralSortOrder = ISNULL(SortOrder, ID)
FROM dbo.TLU_VesselResponseToCetacean
WHERE active = 1
  AND LOWER(LTRIM(RTRIM([Desc]))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
ORDER BY ISNULL(SortOrder, ID), ID;

IF @FisherNeutralID IS NULL
BEGIN
    RAISERROR('Active Neutral row was not found in TLU_FisherResponseToCetacean.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
END;

IF @VesselNeutralID IS NULL
BEGIN
    RAISERROR('Active Neutral row was not found in TLU_VesselResponseToCetacean.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
END;

IF OBJECT_ID('tempdb..#FisherOldNoResponse') IS NOT NULL DROP TABLE #FisherOldNoResponse;
IF OBJECT_ID('tempdb..#VesselOldNoResponse') IS NOT NULL DROP TABLE #VesselOldNoResponse;

SELECT rc.*
INTO #FisherOldNoResponse
FROM dbo.Survey_Sighting_FisherResponseToCetacean rc
LEFT JOIN dbo.TLU_FisherResponseToCetacean md
    ON md.ID = rc.ResponseOptionID
WHERE LOWER(LTRIM(RTRIM(ISNULL(rc.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT = 'no response'
   OR LOWER(LTRIM(RTRIM(ISNULL(md.[Desc], '')))) COLLATE DATABASE_DEFAULT = 'no response';

SELECT rc.*
INTO #VesselOldNoResponse
FROM dbo.Survey_Sighting_VesselResponseToCetacean rc
LEFT JOIN dbo.TLU_VesselResponseToCetacean md
    ON md.ID = rc.ResponseOptionID
WHERE LOWER(LTRIM(RTRIM(ISNULL(rc.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT = 'no response'
   OR LOWER(LTRIM(RTRIM(ISNULL(md.[Desc], '')))) COLLATE DATABASE_DEFAULT = 'no response';

SELECT 'Fisher old No Response rows before cleanup' AS ResultSet, COUNT(*) AS AffectedRows
FROM #FisherOldNoResponse;

SELECT 'Vessel old No Response rows before cleanup' AS ResultSet, COUNT(*) AS AffectedRows
FROM #VesselOldNoResponse;

UPDATE neutral
SET
    neutral.ResponseCount = old.ResponseCount,
    neutral.ResponseOptionID = @FisherNeutralID,
    neutral.ResponseLabel = 'Neutral',
    neutral.SortOrder = @FisherNeutralSortOrder
FROM dbo.Survey_Sighting_FisherResponseToCetacean neutral
INNER JOIN (
    SELECT SightingID, ResponseCount
    FROM (
        SELECT
            SightingID,
            ResponseCount,
            ROW_NUMBER() OVER (
                PARTITION BY SightingID
                ORDER BY CASE WHEN ResponseCount IS NULL THEN 1 ELSE 0 END, ID DESC
            ) AS RowNumber
        FROM #FisherOldNoResponse
    ) ranked
    WHERE RowNumber = 1
) old
    ON old.SightingID = neutral.SightingID
WHERE (
        neutral.ResponseOptionID = @FisherNeutralID
        OR LOWER(LTRIM(RTRIM(ISNULL(neutral.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
      )
  AND neutral.ResponseCount IS NULL
  AND old.ResponseCount IS NOT NULL;

UPDATE oldLive
SET
    oldLive.ResponseOptionID = @FisherNeutralID,
    oldLive.ResponseLabel = 'Neutral',
    oldLive.SortOrder = @FisherNeutralSortOrder
FROM dbo.Survey_Sighting_FisherResponseToCetacean oldLive
INNER JOIN #FisherOldNoResponse oldRows
    ON oldRows.ID = oldLive.ID
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Survey_Sighting_FisherResponseToCetacean neutral
    WHERE neutral.SightingID = oldLive.SightingID
      AND neutral.ID <> oldLive.ID
      AND (
            neutral.ResponseOptionID = @FisherNeutralID
            OR LOWER(LTRIM(RTRIM(ISNULL(neutral.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
          )
);

DELETE oldLive
FROM dbo.Survey_Sighting_FisherResponseToCetacean oldLive
INNER JOIN #FisherOldNoResponse oldRows
    ON oldRows.ID = oldLive.ID
WHERE EXISTS (
    SELECT 1
    FROM dbo.Survey_Sighting_FisherResponseToCetacean neutral
    WHERE neutral.SightingID = oldLive.SightingID
      AND neutral.ID <> oldLive.ID
      AND (
            neutral.ResponseOptionID = @FisherNeutralID
            OR LOWER(LTRIM(RTRIM(ISNULL(neutral.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
          )
);

UPDATE neutral
SET
    neutral.ResponseCount = old.ResponseCount,
    neutral.ResponseOptionID = @VesselNeutralID,
    neutral.ResponseLabel = 'Neutral',
    neutral.SortOrder = @VesselNeutralSortOrder
FROM dbo.Survey_Sighting_VesselResponseToCetacean neutral
INNER JOIN (
    SELECT SightingID, ResponseCount
    FROM (
        SELECT
            SightingID,
            ResponseCount,
            ROW_NUMBER() OVER (
                PARTITION BY SightingID
                ORDER BY CASE WHEN ResponseCount IS NULL THEN 1 ELSE 0 END, ID DESC
            ) AS RowNumber
        FROM #VesselOldNoResponse
    ) ranked
    WHERE RowNumber = 1
) old
    ON old.SightingID = neutral.SightingID
WHERE (
        neutral.ResponseOptionID = @VesselNeutralID
        OR LOWER(LTRIM(RTRIM(ISNULL(neutral.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
      )
  AND neutral.ResponseCount IS NULL
  AND old.ResponseCount IS NOT NULL;

UPDATE oldLive
SET
    oldLive.ResponseOptionID = @VesselNeutralID,
    oldLive.ResponseLabel = 'Neutral',
    oldLive.SortOrder = @VesselNeutralSortOrder
FROM dbo.Survey_Sighting_VesselResponseToCetacean oldLive
INNER JOIN #VesselOldNoResponse oldRows
    ON oldRows.ID = oldLive.ID
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Survey_Sighting_VesselResponseToCetacean neutral
    WHERE neutral.SightingID = oldLive.SightingID
      AND neutral.ID <> oldLive.ID
      AND (
            neutral.ResponseOptionID = @VesselNeutralID
            OR LOWER(LTRIM(RTRIM(ISNULL(neutral.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
          )
);

DELETE oldLive
FROM dbo.Survey_Sighting_VesselResponseToCetacean oldLive
INNER JOIN #VesselOldNoResponse oldRows
    ON oldRows.ID = oldLive.ID
WHERE EXISTS (
    SELECT 1
    FROM dbo.Survey_Sighting_VesselResponseToCetacean neutral
    WHERE neutral.SightingID = oldLive.SightingID
      AND neutral.ID <> oldLive.ID
      AND (
            neutral.ResponseOptionID = @VesselNeutralID
            OR LOWER(LTRIM(RTRIM(ISNULL(neutral.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT LIKE 'neutral%'
          )
);

SELECT 'Fisher old No Response rows after cleanup' AS ResultSet, COUNT(*) AS AffectedRows
FROM dbo.Survey_Sighting_FisherResponseToCetacean rc
LEFT JOIN dbo.TLU_FisherResponseToCetacean md
    ON md.ID = rc.ResponseOptionID
WHERE LOWER(LTRIM(RTRIM(ISNULL(rc.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT = 'no response'
   OR LOWER(LTRIM(RTRIM(ISNULL(md.[Desc], '')))) COLLATE DATABASE_DEFAULT = 'no response';

SELECT 'Vessel old No Response rows after cleanup' AS ResultSet, COUNT(*) AS AffectedRows
FROM dbo.Survey_Sighting_VesselResponseToCetacean rc
LEFT JOIN dbo.TLU_VesselResponseToCetacean md
    ON md.ID = rc.ResponseOptionID
WHERE LOWER(LTRIM(RTRIM(ISNULL(rc.ResponseLabel, '')))) COLLATE DATABASE_DEFAULT = 'no response'
   OR LOWER(LTRIM(RTRIM(ISNULL(md.[Desc], '')))) COLLATE DATABASE_DEFAULT = 'no response';

IF @DryRun = 1
BEGIN
    SELECT 'Dry run only. No changes committed. Set @DryRun = 0 after reviewing the counts.' AS ResultSet;
    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    SELECT 'Cleanup committed.' AS ResultSet;
    COMMIT TRANSACTION;
END;
