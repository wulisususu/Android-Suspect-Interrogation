.class public final synthetic Lcom/google/android/gms/internal/mlkit_vision_barcode/zztr;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Ljava/util/concurrent/Callable;


# instance fields
.field public final synthetic zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;


# direct methods
.method public synthetic constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztr;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    return-void
.end method


# virtual methods
.method public final call()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztr;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzb()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
