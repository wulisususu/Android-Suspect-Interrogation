.class public Lcom/capacitorjs/plugins/camera/ExifWrapper;
.super Ljava/lang/Object;
.source "ExifWrapper.java"


# instance fields
.field private final attributes:[Ljava/lang/String;

.field private final exif:Landroidx/exifinterface/media/ExifInterface;


# direct methods
.method public constructor <init>(Landroidx/exifinterface/media/ExifInterface;)V
    .locals 153

    move-object/from16 v0, p0

    .line 166
    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    const-string v1, "ApertureValue"

    const-string v2, "Artist"

    const-string v3, "BitsPerSample"

    const-string v4, "BodySerialNumber"

    const-string v5, "BrightnessValue"

    const-string v6, "CameraOwnerName"

    const-string v7, "CFAPattern"

    const-string v8, "ColorSpace"

    const-string v9, "ComponentsConfiguration"

    const-string v10, "CompressedBitsPerPixel"

    const-string v11, "Compression"

    const-string v12, "Contrast"

    const-string v13, "Copyright"

    const-string v14, "CustomRendered"

    const-string v15, "DateTime"

    const-string v16, "DateTimeDigitized"

    const-string v17, "DateTimeOriginal"

    const-string v18, "DefaultCropSize"

    const-string v19, "DeviceSettingDescription"

    const-string v20, "DigitalZoomRatio"

    const-string v21, "DNGVersion"

    const-string v22, "ExifVersion"

    const-string v23, "ExposureBiasValue"

    const-string v24, "ExposureIndex"

    const-string v25, "ExposureMode"

    const-string v26, "ExposureProgram"

    const-string v27, "ExposureTime"

    const-string v28, "FileSource"

    const-string v29, "Flash"

    const-string v30, "FlashpixVersion"

    const-string v31, "FlashEnergy"

    const-string v32, "FocalLength"

    const-string v33, "FocalLengthIn35mmFilm"

    const-string v34, "FocalPlaneResolutionUnit"

    const-string v35, "FocalPlaneXResolution"

    const-string v36, "FocalPlaneYResolution"

    const-string v37, "FNumber"

    const-string v38, "GainControl"

    const-string v39, "Gamma"

    const-string v40, "GPSAltitude"

    const-string v41, "GPSAltitudeRef"

    const-string v42, "GPSAreaInformation"

    const-string v43, "GPSDateStamp"

    const-string v44, "GPSDestBearing"

    const-string v45, "GPSDestBearingRef"

    const-string v46, "GPSDestDistance"

    const-string v47, "GPSDestDistanceRef"

    const-string v48, "GPSDestLatitude"

    const-string v49, "GPSDestLatitudeRef"

    const-string v50, "GPSDestLongitude"

    const-string v51, "GPSDestLongitudeRef"

    const-string v52, "GPSDifferential"

    const-string v53, "GPSDOP"

    const-string v54, "GPSHPositioningError"

    const-string v55, "GPSImgDirection"

    const-string v56, "GPSImgDirectionRef"

    const-string v57, "GPSLatitude"

    const-string v58, "GPSLatitudeRef"

    const-string v59, "GPSLongitude"

    const-string v60, "GPSLongitudeRef"

    const-string v61, "GPSMapDatum"

    const-string v62, "GPSMeasureMode"

    const-string v63, "GPSProcessingMethod"

    const-string v64, "GPSSatellites"

    const-string v65, "GPSSpeed"

    const-string v66, "GPSSpeedRef"

    const-string v67, "GPSStatus"

    const-string v68, "GPSTimeStamp"

    const-string v69, "GPSTrack"

    const-string v70, "GPSTrackRef"

    const-string v71, "GPSVersionID"

    const-string v72, "ImageDescription"

    const-string v73, "ImageLength"

    const-string v74, "ImageUniqueID"

    const-string v75, "ImageWidth"

    const-string v76, "InteroperabilityIndex"

    const-string v77, "ISOSpeed"

    const-string v78, "ISOSpeedLatitudeyyy"

    const-string v79, "ISOSpeedLatitudezzz"

    const-string v80, "JPEGInterchangeFormat"

    const-string v81, "JPEGInterchangeFormatLength"

    const-string v82, "LensMake"

    const-string v83, "LensModel"

    const-string v84, "LensSerialNumber"

    const-string v85, "LensSpecification"

    const-string v86, "LightSource"

    const-string v87, "Make"

    const-string v88, "MakerNote"

    const-string v89, "MaxApertureValue"

    const-string v90, "MeteringMode"

    const-string v91, "Model"

    const-string v92, "NewSubfileType"

    const-string v93, "OECF"

    const-string v94, "OffsetTime"

    const-string v95, "OffsetTimeDigitized"

    const-string v96, "OffsetTimeOriginal"

    const-string v97, "AspectFrame"

    const-string v98, "PreviewImageLength"

    const-string v99, "PreviewImageStart"

    const-string v100, "ThumbnailImage"

    const-string v101, "Orientation"

    const-string v102, "PhotographicSensitivity"

    const-string v103, "PhotometricInterpretation"

    const-string v104, "PixelXDimension"

    const-string v105, "PixelYDimension"

    const-string v106, "PlanarConfiguration"

    const-string v107, "PrimaryChromaticities"

    const-string v108, "RecommendedExposureIndex"

    const-string v109, "ReferenceBlackWhite"

    const-string v110, "RelatedSoundFile"

    const-string v111, "ResolutionUnit"

    const-string v112, "RowsPerStrip"

    const-string v113, "ISO"

    const-string v114, "JpgFromRaw"

    const-string v115, "SensorBottomBorder"

    const-string v116, "SensorLeftBorder"

    const-string v117, "SensorRightBorder"

    const-string v118, "SensorTopBorder"

    const-string v119, "SamplesPerPixel"

    const-string v120, "Saturation"

    const-string v121, "SceneCaptureType"

    const-string v122, "SceneType"

    const-string v123, "SensingMethod"

    const-string v124, "SensitivityType"

    const-string v125, "Sharpness"

    const-string v126, "ShutterSpeedValue"

    const-string v127, "Software"

    const-string v128, "SpatialFrequencyResponse"

    const-string v129, "SpectralSensitivity"

    const-string v130, "StandardOutputSensitivity"

    const-string v131, "StripByteCounts"

    const-string v132, "StripOffsets"

    const-string v133, "SubfileType"

    const-string v134, "SubjectArea"

    const-string v135, "SubjectDistance"

    const-string v136, "SubjectDistanceRange"

    const-string v137, "SubjectLocation"

    const-string v138, "SubSecTime"

    const-string v139, "SubSecTimeDigitized"

    const-string v140, "SubSecTimeOriginal"

    const-string v141, "ThumbnailImageLength"

    const-string v142, "ThumbnailImageWidth"

    const-string v143, "TransferFunction"

    const-string v144, "UserComment"

    const-string v145, "WhiteBalance"

    const-string v146, "WhitePoint"

    const-string v147, "Xmp"

    const-string v148, "XResolution"

    const-string v149, "YCbCrCoefficients"

    const-string v150, "YCbCrPositioning"

    const-string v151, "YCbCrSubSampling"

    const-string v152, "YResolution"

    .line 11
    filled-new-array/range {v1 .. v152}, [Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->attributes:[Ljava/lang/String;

    move-object/from16 v1, p1

    iput-object v1, v0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->exif:Landroidx/exifinterface/media/ExifInterface;

    return-void
.end method


# virtual methods
.method public copyExif(Ljava/lang/String;)V
    .locals 3

    .line 191
    :try_start_0
    new-instance v0, Landroidx/exifinterface/media/ExifInterface;

    invoke-direct {v0, p1}, Landroidx/exifinterface/media/ExifInterface;-><init>(Ljava/lang/String;)V

    const/4 p1, 0x0

    :goto_0
    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->attributes:[Ljava/lang/String;

    .line 192
    array-length v2, v1

    if-ge p1, v2, :cond_1

    iget-object v2, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->exif:Landroidx/exifinterface/media/ExifInterface;

    .line 193
    aget-object v1, v1, p1

    invoke-virtual {v2, v1}, Landroidx/exifinterface/media/ExifInterface;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->attributes:[Ljava/lang/String;

    .line 195
    aget-object v2, v2, p1

    invoke-virtual {v0, v2, v1}, Landroidx/exifinterface/media/ExifInterface;->setAttribute(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 198
    :cond_1
    invoke-virtual {v0}, Landroidx/exifinterface/media/ExifInterface;->saveAttributes()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public p(Lcom/getcapacitor/JSObject;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->exif:Landroidx/exifinterface/media/ExifInterface;

    .line 185
    invoke-virtual {v0, p2}, Landroidx/exifinterface/media/ExifInterface;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 186
    invoke-virtual {p1, p2, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    return-void
.end method

.method public resetOrientation()V
    .locals 1

    iget-object v0, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->exif:Landroidx/exifinterface/media/ExifInterface;

    .line 203
    invoke-virtual {v0}, Landroidx/exifinterface/media/ExifInterface;->resetOrientation()V

    return-void
.end method

.method public toJson()Lcom/getcapacitor/JSObject;
    .locals 4

    .line 171
    new-instance v0, Lcom/getcapacitor/JSObject;

    invoke-direct {v0}, Lcom/getcapacitor/JSObject;-><init>()V

    iget-object v1, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->exif:Landroidx/exifinterface/media/ExifInterface;

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;->attributes:[Ljava/lang/String;

    .line 177
    array-length v3, v2

    if-ge v1, v3, :cond_1

    .line 178
    aget-object v2, v2, v1

    invoke-virtual {p0, v0, v2}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->p(Lcom/getcapacitor/JSObject;Ljava/lang/String;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return-object v0
.end method
