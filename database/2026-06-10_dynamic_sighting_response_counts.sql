/*
Run this script before testing the dynamic Fisher/Vessel response sections on the Sighting form.
It creates the child tables used by the new code and backfills existing legacy counts.
Run the backfill before renaming the existing canonical master-data labels
(Approach / No Response / Pull in Line / Relocate / Out of Gear), because
legacy records only store counts in fixed slots and do not store the old option IDs.
*/

IF COL_LENGTH('dbo.TLU_FisherResponseToCetacean', 'SortOrder') IS NULL
BEGIN
    ALTER TABLE dbo.TLU_FisherResponseToCetacean
    ADD SortOrder INT NULL;
END;
GO

UPDATE dbo.TLU_FisherResponseToCetacean
SET SortOrder = ID
WHERE SortOrder IS NULL;
GO

IF COL_LENGTH('dbo.TLU_VesselResponseToCetacean', 'SortOrder') IS NULL
BEGIN
    ALTER TABLE dbo.TLU_VesselResponseToCetacean
    ADD SortOrder INT NULL;
END;
GO

UPDATE dbo.TLU_VesselResponseToCetacean
SET SortOrder = ID
WHERE SortOrder IS NULL;
GO

IF OBJECT_ID('dbo.Survey_Sighting_FisherResponseToCetacean', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Survey_Sighting_FisherResponseToCetacean
    (
        ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        SightingID INT NOT NULL,
        ResponseOptionID INT NULL,
        ResponseLabel NVARCHAR(255) NOT NULL,
        ResponseCount INT NULL,
        SortOrder INT NULL,
        CreatedOn DATETIME NOT NULL CONSTRAINT DF_Survey_Sighting_FisherResponseToCetacean_CreatedOn DEFAULT (GETDATE())
    );
END;
GO

IF OBJECT_ID('dbo.Survey_Sighting_VesselResponseToCetacean', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Survey_Sighting_VesselResponseToCetacean
    (
        ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        SightingID INT NOT NULL,
        ResponseOptionID INT NULL,
        ResponseLabel NVARCHAR(255) NOT NULL,
        ResponseCount INT NULL,
        SortOrder INT NULL,
        CreatedOn DATETIME NOT NULL CONSTRAINT DF_Survey_Sighting_VesselResponseToCetacean_CreatedOn DEFAULT (GETDATE())
    );
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_SightingFisherResponse_Sighting'
)
BEGIN
    ALTER TABLE dbo.Survey_Sighting_FisherResponseToCetacean
    ADD CONSTRAINT FK_SightingFisherResponse_Sighting
        FOREIGN KEY (SightingID) REFERENCES dbo.Survey_Sightings(ID);
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_SightingVesselResponse_Sighting'
)
BEGIN
    ALTER TABLE dbo.Survey_Sighting_VesselResponseToCetacean
    ADD CONSTRAINT FK_SightingVesselResponse_Sighting
        FOREIGN KEY (SightingID) REFERENCES dbo.Survey_Sightings(ID);
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_SightingFisherResponse_Master'
)
BEGIN
    ALTER TABLE dbo.Survey_Sighting_FisherResponseToCetacean
    ADD CONSTRAINT FK_SightingFisherResponse_Master
        FOREIGN KEY (ResponseOptionID) REFERENCES dbo.TLU_FisherResponseToCetacean(ID);
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_SightingVesselResponse_Master'
)
BEGIN
    ALTER TABLE dbo.Survey_Sighting_VesselResponseToCetacean
    ADD CONSTRAINT FK_SightingVesselResponse_Master
        FOREIGN KEY (ResponseOptionID) REFERENCES dbo.TLU_VesselResponseToCetacean(ID);
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_SightingFisherResponse_SightingID'
      AND object_id = OBJECT_ID('dbo.Survey_Sighting_FisherResponseToCetacean')
)
BEGIN
    CREATE INDEX IX_SightingFisherResponse_SightingID
        ON dbo.Survey_Sighting_FisherResponseToCetacean (SightingID, SortOrder);
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_SightingVesselResponse_SightingID'
      AND object_id = OBJECT_ID('dbo.Survey_Sighting_VesselResponseToCetacean')
)
BEGIN
    CREATE INDEX IX_SightingVesselResponse_SightingID
        ON dbo.Survey_Sighting_VesselResponseToCetacean (SightingID, SortOrder);
END;
GO

INSERT INTO dbo.Survey_Sighting_FisherResponseToCetacean
(
    SightingID,
    ResponseOptionID,
    ResponseLabel,
    ResponseCount,
    SortOrder
)
SELECT
    ss.ID,
    md.ID,
    legacy.ResponseLabel,
    legacy.ResponseCount,
    ISNULL(md.MasterSortOrder, legacy.SortOrder)
FROM dbo.Survey_Sightings ss
CROSS APPLY
(
    VALUES
        (N'Approach', ss.FisherResponsetoCetacean1, 1),
        (N'No Response', ss.FisherResponsetoCetacean2, 2),
        (N'Pull in Line', ss.FisherResponsetoCetacean3, 3),
        (N'Relocate', ss.FisherResponsetoCetacean4, 4)
) legacy(ResponseLabel, ResponseCount, SortOrder)
OUTER APPLY
(
    SELECT TOP 1
        ID,
        ISNULL(SortOrder, legacy.SortOrder) AS MasterSortOrder
    FROM dbo.TLU_FisherResponseToCetacean
    WHERE LOWER(LTRIM(RTRIM([Desc]))) = LOWER(LTRIM(RTRIM(legacy.ResponseLabel)))
    ORDER BY ISNULL(SortOrder, ID), ID
) md
WHERE legacy.ResponseCount IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM dbo.Survey_Sighting_FisherResponseToCetacean existing
      WHERE existing.SightingID = ss.ID
        AND existing.ResponseLabel = legacy.ResponseLabel
        AND ISNULL(existing.SortOrder, 0) = ISNULL(md.MasterSortOrder, legacy.SortOrder)
  );
GO

INSERT INTO dbo.Survey_Sighting_VesselResponseToCetacean
(
    SightingID,
    ResponseOptionID,
    ResponseLabel,
    ResponseCount,
    SortOrder
)
SELECT
    ss.ID,
    md.ID,
    legacy.ResponseLabel,
    legacy.ResponseCount,
    ISNULL(md.MasterSortOrder, legacy.SortOrder)
FROM dbo.Survey_Sightings ss
CROSS APPLY
(
    VALUES
        (N'Approach', ss.VesselResponsetoCetacean1, 1),
        (N'No Response', ss.VesselResponsetoCetacean2, 2),
        (N'Out of Gear', ss.VesselResponsetoCetacean3, 3),
        (N'Relocate', ss.VesselResponsetoCetacean4, 4)
) legacy(ResponseLabel, ResponseCount, SortOrder)
OUTER APPLY
(
    SELECT TOP 1
        ID,
        ISNULL(SortOrder, legacy.SortOrder) AS MasterSortOrder
    FROM dbo.TLU_VesselResponseToCetacean
    WHERE LOWER(LTRIM(RTRIM([Desc]))) = LOWER(LTRIM(RTRIM(legacy.ResponseLabel)))
    ORDER BY ISNULL(SortOrder, ID), ID
) md
WHERE legacy.ResponseCount IS NOT NULL
  AND NOT EXISTS
  (
      SELECT 1
      FROM dbo.Survey_Sighting_VesselResponseToCetacean existing
      WHERE existing.SightingID = ss.ID
        AND existing.ResponseLabel = legacy.ResponseLabel
        AND ISNULL(existing.SortOrder, 0) = ISNULL(md.MasterSortOrder, legacy.SortOrder)
  );
GO
