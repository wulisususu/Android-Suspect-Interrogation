.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->ScanScreen(Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;Landroidx/compose/material3/windowsizeclass/WindowSizeClass;Landroidx/compose/runtime/Composer;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Landroid/content/Context;",
        "Landroidx/camera/view/PreviewView;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOSBARCScannerActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OSBARCScannerActivity.kt\ncom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,939:1\n1#2:940\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "Landroidx/camera/view/PreviewView;",
        "context",
        "Landroid/content/Context;",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $cameraProviderFuture:Lcom/google/common/util/concurrent/ListenableFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Landroidx/camera/lifecycle/ProcessCameraProvider;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $lifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

.field final synthetic this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Lcom/google/common/util/concurrent/ListenableFuture;Landroidx/lifecycle/LifecycleOwner;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;",
            "Lcom/google/common/util/concurrent/ListenableFuture<",
            "Landroidx/camera/lifecycle/ProcessCameraProvider;",
            ">;",
            "Landroidx/lifecycle/LifecycleOwner;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->$cameraProviderFuture:Lcom/google/common/util/concurrent/ListenableFuture;

    iput-object p3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->$lifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke(Landroid/content/Context;)Landroidx/camera/view/PreviewView;
    .locals 9

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 290
    new-instance v0, Landroidx/camera/view/PreviewView;

    invoke-direct {v0, p1}, Landroidx/camera/view/PreviewView;-><init>(Landroid/content/Context;)V

    .line 291
    new-instance p1, Landroidx/camera/core/Preview$Builder;

    invoke-direct {p1}, Landroidx/camera/core/Preview$Builder;-><init>()V

    invoke-virtual {p1}, Landroidx/camera/core/Preview$Builder;->build()Landroidx/camera/core/Preview;

    move-result-object p1

    const-string v1, "build(...)"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 292
    invoke-virtual {v0}, Landroidx/camera/view/PreviewView;->getSurfaceProvider()Landroidx/camera/core/Preview$SurfaceProvider;

    move-result-object v2

    invoke-virtual {p1, v2}, Landroidx/camera/core/Preview;->setSurfaceProvider(Landroidx/camera/core/Preview$SurfaceProvider;)V

    .line 294
    new-instance v2, Landroidx/camera/core/resolutionselector/ResolutionSelector$Builder;

    invoke-direct {v2}, Landroidx/camera/core/resolutionselector/ResolutionSelector$Builder;-><init>()V

    .line 295
    new-instance v3, Landroidx/camera/core/resolutionselector/ResolutionStrategy;

    new-instance v4, Landroid/util/Size;

    const/16 v5, 0x780

    const/16 v6, 0x438

    invoke-direct {v4, v5, v6}, Landroid/util/Size;-><init>(II)V

    const/4 v5, 0x1

    invoke-direct {v3, v4, v5}, Landroidx/camera/core/resolutionselector/ResolutionStrategy;-><init>(Landroid/util/Size;I)V

    .line 294
    invoke-virtual {v2, v3}, Landroidx/camera/core/resolutionselector/ResolutionSelector$Builder;->setResolutionStrategy(Landroidx/camera/core/resolutionselector/ResolutionStrategy;)Landroidx/camera/core/resolutionselector/ResolutionSelector$Builder;

    move-result-object v2

    .line 297
    invoke-virtual {v2}, Landroidx/camera/core/resolutionselector/ResolutionSelector$Builder;->build()Landroidx/camera/core/resolutionselector/ResolutionSelector;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 298
    new-instance v3, Landroidx/camera/core/ImageAnalysis$Builder;

    invoke-direct {v3}, Landroidx/camera/core/ImageAnalysis$Builder;-><init>()V

    .line 299
    invoke-virtual {v3, v2}, Landroidx/camera/core/ImageAnalysis$Builder;->setResolutionSelector(Landroidx/camera/core/resolutionselector/ResolutionSelector;)Landroidx/camera/core/ImageAnalysis$Builder;

    move-result-object v2

    const/4 v3, 0x0

    .line 300
    invoke-virtual {v2, v3}, Landroidx/camera/core/ImageAnalysis$Builder;->setBackpressureStrategy(I)Landroidx/camera/core/ImageAnalysis$Builder;

    move-result-object v2

    .line 301
    invoke-virtual {v2}, Landroidx/camera/core/ImageAnalysis$Builder;->build()Landroidx/camera/core/ImageAnalysis;

    move-result-object v2

    invoke-static {v2, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 303
    invoke-static {v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$getCameraExecutor$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    const/4 v4, 0x0

    if-nez v1, :cond_0

    const-string v1, "cameraExecutor"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v1, v4

    :cond_0
    check-cast v1, Ljava/util/concurrent/Executor;

    iget-object v6, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 304
    invoke-static {v6}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$getBarcodeAnalyzer$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;

    move-result-object v6

    if-nez v6, :cond_1

    const-string v6, "barcodeAnalyzer"

    invoke-static {v6}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    move-object v6, v4

    :cond_1
    check-cast v6, Landroidx/camera/core/ImageAnalysis$Analyzer;

    .line 302
    invoke-virtual {v2, v1, v6}, Landroidx/camera/core/ImageAnalysis;->setAnalyzer(Ljava/util/concurrent/Executor;Landroidx/camera/core/ImageAnalysis$Analyzer;)V

    :try_start_0
    iget-object v1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iget-object v6, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->$cameraProviderFuture:Lcom/google/common/util/concurrent/ListenableFuture;

    .line 307
    invoke-interface {v6}, Lcom/google/common/util/concurrent/ListenableFuture;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroidx/camera/lifecycle/ProcessCameraProvider;

    iget-object v7, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->$lifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

    iget-object v8, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 309
    invoke-static {v8}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$getSelector$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;)Landroidx/camera/core/CameraSelector;

    move-result-object v8

    if-nez v8, :cond_2

    const-string v8, "selector"

    invoke-static {v8}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    move-object v4, v8

    :goto_0
    const/4 v8, 0x2

    new-array v8, v8, [Landroidx/camera/core/UseCase;

    .line 310
    aput-object p1, v8, v3

    .line 311
    aput-object v2, v8, v5

    .line 307
    invoke-virtual {v6, v7, v4, v8}, Landroidx/camera/lifecycle/ProcessCameraProvider;->bindToLifecycle(Landroidx/lifecycle/LifecycleOwner;Landroidx/camera/core/CameraSelector;[Landroidx/camera/core/UseCase;)Landroidx/camera/core/Camera;

    move-result-object p1

    const-string v2, "bindToLifecycle(...)"

    invoke-static {p1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v1, p1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$setCamera$p(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/camera/core/Camera;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    .line 314
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    const-string v1, "OSBARCScannerActivity"

    invoke-static {v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_3
    iget-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 315
    sget-object v1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {v1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result v1

    invoke-virtual {p1, v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->setResult(I)V

    iget-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 316
    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->finish()V

    :goto_1
    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 288
    check-cast p1, Landroid/content/Context;

    invoke-virtual {p0, p1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$5$1;->invoke(Landroid/content/Context;)Landroidx/camera/view/PreviewView;

    move-result-object p1

    return-object p1
.end method
