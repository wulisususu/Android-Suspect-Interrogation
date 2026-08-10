.class final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzct;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbg;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# instance fields
.field private final zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;I)V
    .locals 1

    .line 1
    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;->size()I

    move-result v0

    invoke-direct {p0, v0, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbg;-><init>(II)V

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzct;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;

    return-void
.end method


# virtual methods
.method protected final zza(I)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzct;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;

    .line 1
    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;->get(I)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
