---- Update Parcels with hazard data ----

-- Update Earthquake Hazard zone --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [EARTHQUAKE_HAZARD] = 'MMI of 7 or Higher'--(b.GRID_CODE)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_EARTHQUAKEHAZARD_MI] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1 and b.PARAMVALUE >= 7

-- Update Fire Hazard zone LRA --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FIRE_HAZARD] = (b.HAZ_CLASS)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_FHSZ_LRA_VeryHigh] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1

-- Update Fire Hazard zone SRA --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FIRE_HAZARD] = (b.HAZ_CLASS)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_FHSZ_SRA_VeryHigh] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1

-- Update 100 yr Plus (Tsunami Innundation) flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FLOOD_100_YR_PLUS] = (100)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_Tsunami2009]b
ON a.SHAPE.STIntersects(b.SHAPE) = 1


-- Update 100 yr flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FLOOD_100_YR] = (b.FloodZone)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_100_500_YEAR_FLOODPLAINS] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1 and b.FloodZone = '100' and b.FloodZone != '500'


-- Update 500 yr flood field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [FLOOD_500_YR] = (b.FloodZone)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_100_500_YEAR_FLOODPLAINS] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1 and b.FloodZone = '500' and b.FloodZone != '100'


-- Update mhhw  --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [MHHW_2100] = ('YES')
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_MHHW_2100] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1


-- Update CoastFlood --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [COAST_YR_2100_FLOOD] = ('YES')
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_COAST_YR_2100_FLOOD] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1


-- Update Prado Dam Innundation Zone --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [DAM_INUNDATION] = ('Prado')
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[PRADODAMINUNDATION]b
ON a.SHAPE.STIntersects(b.SHAPE) = 1


-- Update Census Block Name field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [BLOCK_NAME] = (b.NAME)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_Block] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1

-- Update Census GEOID field --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [GEOID] = (b.GEOID)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_Block] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1

-- Update USGS Landslide Hazard Confidence Field SSF --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [LANDSLIDE] = (5)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_ls_ssf] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1

-- Update USGS Landslide Hazard Confidence Field SOURCE --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [LANDSLIDE] = (5)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_ls_source] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1

-- Update USGS Landslide Hazard Confidence Field DEPOSIT --
UPDATE [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA]
SET [LANDSLIDE] = (5)
FROM [OCSurvey].[dbo].[HM_2020_LEGAL_LOTS_ALL_DATA] a WITH (NOLOCK, index(S1169_idx))
JOIN [OCSurvey].[dbo].[HM_2020_ls_deposit] b
ON a.SHAPE.STIntersects(b.SHAPE) = 1
