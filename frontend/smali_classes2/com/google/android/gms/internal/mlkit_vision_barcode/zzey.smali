.class final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode/zzei;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Ljava/util/concurrent/RunnableFuture;


# instance fields
.field private volatile zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;
    .annotation runtime Ljavax/annotation/CheckForNull;
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzup;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzei;-><init>()V

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzex;

    invoke-direct {v0, p0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzex;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzup;)V

    iput-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;

    if-eqz v0, :cond_0

    .line 1
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;->run()V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;

    return-void
.end method

.method protected final zze()Ljava/lang/String;
    .locals 3
    .annotation runtime Ljavax/annotation/CheckForNull;
    .end annotation

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;

    if-eqz v0, :cond_0

    .line 1
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "task=["

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "]"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 2
    :cond_0
    invoke-super {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzei;->zze()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected final zzk()V
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzec;->zzn()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;->zze()V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzey;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzeu;

    return-void
.end method
