.class public final synthetic Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

.field public final synthetic zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

.field public final synthetic zzc:Lcom/google/mlkit/vision/barcode/internal/zzj;


# direct methods
.method public synthetic constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Lcom/google/mlkit/vision/barcode/internal/zzj;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iput-object p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;->zzc:Lcom/google/mlkit/vision/barcode/internal/zzj;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    iget-object v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztv;->zzc:Lcom/google/mlkit/vision/barcode/internal/zzj;

    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Lcom/google/mlkit/vision/barcode/internal/zzj;)V

    return-void
.end method
