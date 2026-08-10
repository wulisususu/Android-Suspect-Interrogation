.class final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode/zzek;


# instance fields
.field final synthetic zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

.field final synthetic zzb:F

.field final synthetic zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;

.field final synthetic zzd:F

.field final synthetic zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;FLcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;F)V
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zzb:F

    iput-object p4, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;

    iput p5, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zzd:F

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final zza(Ljava/lang/Throwable;)V
    .locals 4

    .line 1
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzb()Lcom/google/android/gms/common/internal/GmsLogger;

    move-result-object v0

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zzd:F

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Unable to set zoom to "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "AutoZoom"

    invoke-virtual {v0, v2, v1, p1}, Lcom/google/android/gms/common/internal/GmsLogger;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    invoke-static {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object p1

    const/4 v0, 0x0

    .line 2
    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void
.end method

.method public final bridge synthetic zzb(Ljava/lang/Object;)V
    .locals 4

    .line 1
    check-cast p1, Ljava/lang/Float;

    .line 2
    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result v0

    const/high16 v1, 0x3f800000    # 1.0f

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    .line 3
    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;F)V

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    iget-object v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zzb:F

    .line 4
    invoke-virtual {p1}, Ljava/lang/Float;->floatValue()F

    move-result p1

    iget-object v3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;

    invoke-static {v0, v1, v2, p1, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzh(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;FFLcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;)V

    :cond_0
    iget-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzur;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    invoke-static {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;)Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object p1

    const/4 v0, 0x0

    .line 5
    invoke-virtual {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    return-void
.end method
