.class public final synthetic Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

.field public final synthetic zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

.field public final synthetic zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

.field public final synthetic zzd:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    iput-object p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iput-object p4, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zzd:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 4

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    iget-object v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    iget-object v3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztt;->zzd:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzc(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Ljava/lang/String;)V

    return-void
.end method
