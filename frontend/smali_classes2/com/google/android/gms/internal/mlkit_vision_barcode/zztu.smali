.class public final synthetic Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

.field public final synthetic zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

.field public final synthetic zzc:Ljava/lang/Object;

.field public final synthetic zzd:J

.field public final synthetic zze:Lcom/google/mlkit/vision/barcode/internal/zzj;


# direct methods
.method public synthetic constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Ljava/lang/Object;JLcom/google/mlkit/vision/barcode/internal/zzj;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iput-object p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zzc:Ljava/lang/Object;

    iput-wide p4, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zzd:J

    iput-object p6, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zze:Lcom/google/mlkit/vision/barcode/internal/zzj;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 6

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    iget-object v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zzc:Ljava/lang/Object;

    iget-wide v3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zzd:J

    iget-object v5, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;->zze:Lcom/google/mlkit/vision/barcode/internal/zzj;

    invoke-virtual/range {v0 .. v5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzh(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Ljava/lang/Object;JLcom/google/mlkit/vision/barcode/internal/zzj;)V

    return-void
.end method
