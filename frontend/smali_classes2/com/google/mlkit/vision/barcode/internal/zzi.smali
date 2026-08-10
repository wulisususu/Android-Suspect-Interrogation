.class public final synthetic Lcom/google/mlkit/vision/barcode/internal/zzi;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode/zztw;


# instance fields
.field public final synthetic zza:Lcom/google/mlkit/vision/barcode/internal/zzk;

.field public final synthetic zzb:J

.field public final synthetic zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;

.field public final synthetic zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

.field public final synthetic zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

.field public final synthetic zzf:Lcom/google/mlkit/vision/common/InputImage;


# direct methods
.method public synthetic constructor <init>(Lcom/google/mlkit/vision/barcode/internal/zzk;JLcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/mlkit/vision/common/InputImage;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zza:Lcom/google/mlkit/vision/barcode/internal/zzk;

    iput-wide p2, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzb:J

    iput-object p4, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;

    iput-object p5, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    iput-object p6, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    iput-object p7, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzf:Lcom/google/mlkit/vision/common/InputImage;

    return-void
.end method


# virtual methods
.method public final zza()Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;
    .locals 7

    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zza:Lcom/google/mlkit/vision/barcode/internal/zzk;

    iget-wide v1, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzb:J

    iget-object v3, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;

    iget-object v4, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    iget-object v5, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    iget-object v6, p0, Lcom/google/mlkit/vision/barcode/internal/zzi;->zzf:Lcom/google/mlkit/vision/common/InputImage;

    invoke-virtual/range {v0 .. v6}, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzc(JLcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    move-result-object v0

    return-object v0
.end method
