.class public final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# static fields
.field private static zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;


# direct methods
.method public static declared-synchronized zza(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztp;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;
    .locals 3

    const-class v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;

    if-nez v1, :cond_0

    .line 1
    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzug;)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;

    :cond_0
    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;

    .line 2
    invoke-virtual {v1, p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuh;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized zzb(Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;
    .locals 1

    const-class v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;

    monitor-enter v0

    .line 1
    :try_start_0
    invoke-static {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztp;->zzd(Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzto;

    move-result-object p0

    .line 2
    invoke-virtual {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzto;->zzd()Lcom/google/android/gms/internal/mlkit_vision_barcode/zztp;

    move-result-object p0

    .line 3
    invoke-static {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzui;->zza(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztp;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method
