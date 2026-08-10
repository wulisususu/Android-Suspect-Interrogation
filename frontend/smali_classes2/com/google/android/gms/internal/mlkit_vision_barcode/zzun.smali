.class final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# instance fields
.field private final zzc:I

.field private final zzd:I

.field private final zze:F

.field private final zzf:F

.field private final zzg:Z

.field private final zzh:F

.field private final zzi:F

.field private final zzj:J

.field private final zzk:J

.field private final zzl:Z

.field private final zzm:F

.field private final zzn:F


# direct methods
.method synthetic constructor <init>(IIFFZFFJJZFFLcom/google/android/gms/internal/mlkit_vision_barcode/zzum;)V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;-><init>()V

    iput p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzc:I

    iput p2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzd:I

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zze:F

    iput p4, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzf:F

    iput-boolean p5, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzg:Z

    iput p6, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzh:F

    iput p7, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzi:F

    iput-wide p8, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzj:J

    iput-wide p10, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzk:J

    iput-boolean p12, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzl:Z

    iput p13, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzm:F

    iput p14, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzn:F

    return-void
.end method


# virtual methods
.method public final equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 1
    :cond_0
    instance-of v1, p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    check-cast p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzc:I

    .line 2
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzh()I

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzd:I

    .line 3
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzg()I

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zze:F

    .line 4
    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzd()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzf:F

    .line 5
    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzc()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v3

    if-ne v1, v3, :cond_1

    iget-boolean v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzg:Z

    .line 6
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzl()Z

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzh:F

    .line 7
    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzb()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzi:F

    .line 8
    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zza()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v3

    if-ne v1, v3, :cond_1

    iget-wide v3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzj:J

    .line 9
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzj()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_1

    iget-wide v3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzk:J

    .line 10
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzi()J

    move-result-wide v5

    cmp-long v1, v3, v5

    if-nez v1, :cond_1

    iget-boolean v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzl:Z

    .line 11
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzk()Z

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzm:F

    .line 12
    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zze()F

    move-result v3

    invoke-static {v3}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v3

    if-ne v1, v3, :cond_1

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzn:F

    .line 13
    invoke-static {v1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuu;->zzf()F

    move-result p1

    invoke-static {p1}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result p1

    if-ne v1, p1, :cond_1

    return v0

    :cond_1
    return v2
.end method

.method public final hashCode()I
    .locals 8

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzc:I

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzd:I

    xor-int/2addr v0, v2

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zze:F

    .line 1
    invoke-static {v2}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v2

    mul-int/2addr v0, v1

    xor-int/2addr v0, v2

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzf:F

    .line 2
    invoke-static {v2}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v2

    mul-int/2addr v0, v1

    xor-int/2addr v0, v2

    iget-boolean v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzg:Z

    const/16 v3, 0x4d5

    const/16 v4, 0x4cf

    const/4 v5, 0x1

    if-eq v5, v2, :cond_0

    move v2, v3

    goto :goto_0

    :cond_0
    move v2, v4

    :goto_0
    iget v6, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzh:F

    .line 3
    invoke-static {v6}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v6

    mul-int/2addr v0, v1

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    xor-int/2addr v0, v6

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzi:F

    .line 4
    invoke-static {v2}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v2

    mul-int/2addr v0, v1

    xor-int/2addr v0, v2

    iget-wide v6, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzj:J

    long-to-int v2, v6

    iget-wide v6, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzk:J

    long-to-int v6, v6

    iget-boolean v7, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzl:Z

    if-eq v5, v7, :cond_1

    goto :goto_1

    :cond_1
    move v3, v4

    :goto_1
    iget v4, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzm:F

    .line 5
    invoke-static {v4}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v4

    mul-int/2addr v0, v1

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    xor-int/2addr v0, v6

    mul-int/2addr v0, v1

    xor-int/2addr v0, v3

    mul-int/2addr v0, v1

    xor-int/2addr v0, v4

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzn:F

    .line 6
    invoke-static {v2}, Ljava/lang/Float;->floatToIntBits(F)I

    move-result v2

    mul-int/2addr v0, v1

    xor-int/2addr v0, v2

    return v0
.end method

.method public final toString()Ljava/lang/String;
    .locals 16

    move-object/from16 v0, p0

    iget v1, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzc:I

    iget v2, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzd:I

    iget v3, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zze:F

    iget v4, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzf:F

    iget-boolean v5, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzg:Z

    iget v6, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzh:F

    iget v7, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzi:F

    iget-wide v8, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzj:J

    iget-wide v10, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzk:J

    iget-boolean v12, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzl:Z

    iget v13, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzm:F

    iget v14, v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzn:F

    .line 1
    new-instance v15, Ljava/lang/StringBuilder;

    const-string v0, "AutoZoomOptions{recentFramesToCheck="

    invoke-direct {v15, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v15, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ", recentFramesContainingPredictedArea="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ", recentFramesIou="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v3}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, ", maxCoverage="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v4}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, ", useConfidenceScore="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v0, ", lowerConfidenceScore="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v6}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, ", higherConfidenceScore="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v7}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, ", zoomIntervalInMillis="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v0, ", resetIntervalInMillis="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v0, ", enableZoomThreshold="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v0, ", zoomInThreshold="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v13}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v0, ", zoomOutThreshold="

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v14}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string/jumbo v0, "}"

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method final zza()F
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzi:F

    return v0
.end method

.method final zzb()F
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzh:F

    return v0
.end method

.method final zzc()F
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzf:F

    return v0
.end method

.method final zzd()F
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zze:F

    return v0
.end method

.method final zze()F
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzm:F

    return v0
.end method

.method final zzf()F
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzn:F

    return v0
.end method

.method final zzg()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzd:I

    return v0
.end method

.method final zzh()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzc:I

    return v0
.end method

.method final zzi()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzk:J

    return-wide v0
.end method

.method final zzj()J
    .locals 2

    iget-wide v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzj:J

    return-wide v0
.end method

.method final zzk()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzl:Z

    return v0
.end method

.method final zzl()Z
    .locals 1

    iget-boolean v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzun;->zzg:Z

    return v0
.end method
