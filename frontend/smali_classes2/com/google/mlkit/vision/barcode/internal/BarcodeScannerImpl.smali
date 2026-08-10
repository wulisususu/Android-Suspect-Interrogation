.class public Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;
.super Lcom/google/mlkit/vision/common/internal/MobileVisionBase;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Lcom/google/mlkit/vision/barcode/BarcodeScanner;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/google/mlkit/vision/common/internal/MobileVisionBase<",
        "Ljava/util/List<",
        "Lcom/google/mlkit/vision/barcode/common/Barcode;",
        ">;>;",
        "Lcom/google/mlkit/vision/barcode/BarcodeScanner;"
    }
.end annotation


# static fields
.field public static final synthetic zzc:I

.field private static final zzd:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;


# instance fields
.field final zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;
    .annotation runtime Ljavax/annotation/Nullable;
    .end annotation
.end field

.field private final zze:Z

.field private final zzf:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

.field private zzg:I

.field private zzh:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;

    invoke-direct {v0}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;-><init>()V

    invoke-virtual {v0}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions$Builder;->build()Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    move-result-object v0

    sput-object v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzd:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    return-void
.end method

.method constructor <init>(Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;Lcom/google/mlkit/vision/barcode/internal/zzk;Ljava/util/concurrent/Executor;Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;Lcom/google/mlkit/common/sdkinternal/MlKitContext;)V
    .locals 3

    .line 1
    invoke-virtual {p1}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;->zzb()Lcom/google/mlkit/vision/barcode/ZoomSuggestionOptions;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 p5, 0x0

    goto :goto_0

    .line 2
    :cond_0
    invoke-virtual {p5}, Lcom/google/mlkit/common/sdkinternal/MlKitContext;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 3
    invoke-virtual {p5}, Lcom/google/mlkit/common/sdkinternal/MlKitContext;->getApplicationContext()Landroid/content/Context;

    move-result-object p5

    invoke-virtual {p5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p5

    .line 4
    invoke-static {v1, p5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzd(Landroid/content/Context;Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    move-result-object p5

    new-instance v1, Lcom/google/mlkit/vision/barcode/internal/zzf;

    invoke-direct {v1, v0}, Lcom/google/mlkit/vision/barcode/internal/zzf;-><init>(Lcom/google/mlkit/vision/barcode/ZoomSuggestionOptions;)V

    .line 5
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzew;->zza()Ljava/util/concurrent/Executor;

    move-result-object v2

    .line 6
    invoke-virtual {p5, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzo(Lcom/google/mlkit/vision/barcode/internal/zzf;Ljava/util/concurrent/Executor;)V

    invoke-virtual {v0}, Lcom/google/mlkit/vision/barcode/ZoomSuggestionOptions;->zza()F

    move-result v1

    const/high16 v2, 0x3f800000    # 1.0f

    cmpl-float v1, v1, v2

    if-ltz v1, :cond_1

    invoke-virtual {v0}, Lcom/google/mlkit/vision/barcode/ZoomSuggestionOptions;->zza()F

    move-result v0

    .line 7
    invoke-virtual {p5, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzk(F)V

    .line 8
    :cond_1
    invoke-virtual {p5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzm()V

    .line 9
    :goto_0
    invoke-direct {p0, p2, p3}, Lcom/google/mlkit/vision/common/internal/MobileVisionBase;-><init>(Lcom/google/mlkit/common/sdkinternal/MLTask;Ljava/util/concurrent/Executor;)V

    iput-object p1, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzf:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    .line 10
    invoke-static {}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zzf()Z

    move-result p2

    iput-boolean p2, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zze:Z

    new-instance p3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    invoke-direct {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;-><init>()V

    .line 11
    invoke-static {p1}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zzc(Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzi(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzj()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpz;

    move-result-object p1

    new-instance p3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    invoke-direct {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;-><init>()V

    if-eqz p2, :cond_2

    .line 12
    sget-object p2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    goto :goto_1

    :cond_2
    sget-object p2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    :goto_1
    invoke-virtual {p3, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    .line 13
    invoke-virtual {p3, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpz;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    const/4 p1, 0x1

    .line 14
    invoke-static {p3, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzua;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;I)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    move-result-object p1

    sget-object p2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    .line 15
    invoke-virtual {p4, p1, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzd(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;)V

    iput-object p5, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    return-void
.end method

.method static bridge synthetic zze()Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;
    .locals 1

    sget-object v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzd:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    return-object v0
.end method

.method private final zzf(Lcom/google/android/gms/tasks/Task;II)Lcom/google/android/gms/tasks/Task;
    .locals 1

    .line 1
    new-instance v0, Lcom/google/mlkit/vision/barcode/internal/zze;

    invoke-direct {v0, p0, p2, p3}, Lcom/google/mlkit/vision/barcode/internal/zze;-><init>(Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;II)V

    invoke-virtual {p1, v0}, Lcom/google/android/gms/tasks/Task;->onSuccessTask(Lcom/google/android/gms/tasks/SuccessContinuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public final declared-synchronized close()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    if-eqz v0, :cond_0

    iget-boolean v1, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzh:Z

    .line 1
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzn(Z)V

    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    .line 2
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzj()V

    .line 3
    :cond_0
    invoke-super {p0}, Lcom/google/mlkit/vision/common/internal/MobileVisionBase;->close()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final getDetectorType()I
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public final getOptionalFeatures()[Lcom/google/android/gms/common/Feature;
    .locals 3

    iget-boolean v0, p0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zze:Z

    if-eqz v0, :cond_0

    .line 1
    sget-object v0, Lcom/google/mlkit/common/sdkinternal/OptionalModuleUtils;->EMPTY_FEATURES:[Lcom/google/android/gms/common/Feature;

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    new-array v0, v0, [Lcom/google/android/gms/common/Feature;

    const/4 v1, 0x0

    .line 2
    sget-object v2, Lcom/google/mlkit/common/sdkinternal/OptionalModuleUtils;->FEATURE_BARCODE:Lcom/google/android/gms/common/Feature;

    aput-object v2, v0, v1

    :goto_0
    return-object v0
.end method

.method public final process(Lcom/google/android/odml/image/MlImage;)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/android/odml/image/MlImage;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/util/List<",
            "Lcom/google/mlkit/vision/barcode/common/Barcode;",
            ">;>;"
        }
    .end annotation

    .line 1
    invoke-super {p0, p1}, Lcom/google/mlkit/vision/common/internal/MobileVisionBase;->processBase(Lcom/google/android/odml/image/MlImage;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    invoke-virtual {p1}, Lcom/google/android/odml/image/MlImage;->getWidth()I

    move-result v1

    invoke-virtual {p1}, Lcom/google/android/odml/image/MlImage;->getHeight()I

    move-result p1

    invoke-direct {p0, v0, v1, p1}, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzf(Lcom/google/android/gms/tasks/Task;II)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public final process(Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/tasks/Task;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/google/mlkit/vision/common/InputImage;",
            ")",
            "Lcom/google/android/gms/tasks/Task<",
            "Ljava/util/List<",
            "Lcom/google/mlkit/vision/barcode/common/Barcode;",
            ">;>;"
        }
    .end annotation

    .line 2
    invoke-super {p0, p1}, Lcom/google/mlkit/vision/common/internal/MobileVisionBase;->processBase(Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    invoke-virtual {p1}, Lcom/google/mlkit/vision/common/InputImage;->getWidth()I

    move-result v1

    invoke-virtual {p1}, Lcom/google/mlkit/vision/common/InputImage;->getHeight()I

    move-result p1

    invoke-direct {p0, v0, v1, p1}, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzf(Lcom/google/android/gms/tasks/Task;II)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method final synthetic zzd(IILjava/util/List;)Lcom/google/android/gms/tasks/Task;
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    if-nez v1, :cond_0

    .line 1
    invoke-static/range {p3 .. p3}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    return-object v1

    :cond_0
    iget v1, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzg:I

    const/4 v2, 0x1

    add-int/2addr v1, v2

    iput v1, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzg:I

    new-instance v1, Ljava/util/ArrayList;

    .line 2
    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    new-instance v3, Ljava/util/ArrayList;

    .line 3
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 4
    invoke-interface/range {p3 .. p3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/google/mlkit/vision/barcode/common/Barcode;

    .line 5
    invoke-virtual {v5}, Lcom/google/mlkit/vision/barcode/common/Barcode;->getFormat()I

    move-result v6

    const/4 v7, -0x1

    if-ne v6, v7, :cond_1

    .line 6
    invoke-interface {v3, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 7
    :cond_1
    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 8
    :cond_2
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    const/4 v6, 0x0

    :goto_1
    if-ge v6, v4, :cond_6

    invoke-interface {v3, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    .line 9
    check-cast v7, Lcom/google/mlkit/vision/barcode/common/Barcode;

    .line 10
    invoke-virtual {v7}, Lcom/google/mlkit/vision/barcode/common/Barcode;->getCornerPoints()[Landroid/graphics/Point;

    move-result-object v7

    if-eqz v7, :cond_4

    iget-object v8, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;

    iget v9, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzg:I

    .line 11
    invoke-static {v7}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v7

    .line 12
    invoke-interface {v7}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    move/from16 v10, p1

    move/from16 v11, p2

    const/4 v12, 0x0

    const/4 v13, 0x0

    :goto_2
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v14

    if-eqz v14, :cond_3

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Landroid/graphics/Point;

    .line 13
    iget v15, v14, Landroid/graphics/Point;->x:I

    invoke-static {v10, v15}, Ljava/lang/Math;->min(II)I

    move-result v10

    .line 14
    iget v15, v14, Landroid/graphics/Point;->y:I

    invoke-static {v11, v15}, Ljava/lang/Math;->min(II)I

    move-result v11

    .line 15
    iget v15, v14, Landroid/graphics/Point;->x:I

    invoke-static {v12, v15}, Ljava/lang/Math;->max(II)I

    move-result v12

    .line 16
    iget v14, v14, Landroid/graphics/Point;->y:I

    invoke-static {v13, v14}, Ljava/lang/Math;->max(II)I

    move-result v13

    goto :goto_2

    :cond_3
    int-to-float v7, v10

    const/4 v10, 0x0

    add-float/2addr v7, v10

    move/from16 v14, p1

    int-to-float v15, v14

    int-to-float v11, v11

    add-float/2addr v11, v10

    move/from16 v5, p2

    int-to-float v2, v5

    int-to-float v12, v12

    int-to-float v13, v13

    div-float/2addr v7, v15

    div-float/2addr v11, v2

    add-float/2addr v12, v10

    div-float/2addr v12, v15

    add-float/2addr v13, v10

    div-float/2addr v13, v2

    invoke-static {v7, v11, v12, v13, v10}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;->zzg(FFFFF)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;

    move-result-object v2

    .line 17
    invoke-virtual {v8, v9, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzus;->zzi(ILcom/google/android/gms/internal/mlkit_vision_barcode/zzuv;)V

    goto :goto_3

    :cond_4
    move/from16 v14, p1

    move/from16 v5, p2

    :goto_3
    add-int/lit8 v6, v6, 0x1

    const/4 v2, 0x1

    goto :goto_1

    :cond_5
    iput-boolean v2, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzh:Z

    :cond_6
    iget-object v3, v0, Lcom/google/mlkit/vision/barcode/internal/BarcodeScannerImpl;->zzf:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    .line 18
    invoke-virtual {v3}, Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;->zzd()Z

    move-result v3

    if-eq v2, v3, :cond_7

    goto :goto_4

    :cond_7
    move-object/from16 v1, p3

    .line 19
    :goto_4
    invoke-static {v1}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    return-object v1
.end method
