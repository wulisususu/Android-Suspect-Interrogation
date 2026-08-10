.class public final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# instance fields
.field private zza:I

.field private final zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    iput-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    return-void
.end method


# virtual methods
.method public final zza(I)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;
    .locals 0

    iput p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;->zza:I

    return-object p0
.end method

.method public final zzb()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfg;
    .locals 3

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfb;

    iget v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;->zza:I

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfc;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzff;

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfb;-><init>(ILcom/google/android/gms/internal/mlkit_vision_barcode/zzff;)V

    return-object v0
.end method
