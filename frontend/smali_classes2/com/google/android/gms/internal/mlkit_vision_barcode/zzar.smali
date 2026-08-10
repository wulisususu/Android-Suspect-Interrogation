.class public final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzar;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# static fields
.field private static final zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbf;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzap;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzap;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 2
    :catchall_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzaq;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzaq;-><init>()V

    :goto_0
    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzar;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbf;

    return-void
.end method

.method public static zza()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbf;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzar;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbf;

    return-object v0
.end method
