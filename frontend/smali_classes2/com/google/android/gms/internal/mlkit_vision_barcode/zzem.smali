.class public final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzem;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeo;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# direct methods
.method public static zza(Ljava/lang/Object;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzev;
    .locals 1

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzep;

    invoke-direct {v0, p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzep;-><init>(Ljava/lang/Object;)V

    return-object v0
.end method

.method public static zzb(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzev;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzek;Ljava/util/concurrent/Executor;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzel;

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzel;-><init>(Ljava/util/concurrent/Future;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzek;)V

    invoke-interface {p0, v0, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzev;->zzj(Ljava/lang/Runnable;Ljava/util/concurrent/Executor;)V

    return-void
.end method

.method public static zzc(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzup;Ljava/util/concurrent/Executor;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzev;
    .locals 0

    .line 1
    new-instance p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;

    .line 2
    invoke-direct {p1, p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzup;)V

    .line 3
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-object p1
.end method
