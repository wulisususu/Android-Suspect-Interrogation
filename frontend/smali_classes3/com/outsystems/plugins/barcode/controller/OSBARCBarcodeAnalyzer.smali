.class public final Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;
.super Ljava/lang/Object;
.source "OSBARCBarcodeAnalyzer.kt"

# interfaces
.implements Landroidx/camera/core/ImageAnalysis$Analyzer;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOSBARCBarcodeAnalyzer.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OSBARCBarcodeAnalyzer.kt\ncom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,88:1\n1#2:89\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000B\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u0007\u0018\u0000 \u00182\u00020\u0001:\u0001\u0018B=\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u0012\u0012\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\t0\u0007\u0012\u0012\u0010\n\u001a\u000e\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\t0\u0007\u00a2\u0006\u0002\u0010\u000cJ\u0010\u0010\u0012\u001a\u00020\t2\u0006\u0010\u0013\u001a\u00020\u0014H\u0016J\u0010\u0010\u0015\u001a\u00020\u00162\u0006\u0010\u0017\u001a\u00020\u0016H\u0002R\u000e\u0010\u0004\u001a\u00020\u0005X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\r\u001a\u00020\u000eX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\t0\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\n\u001a\u000e\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\t0\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;",
        "Landroidx/camera/core/ImageAnalysis$Analyzer;",
        "scanLibrary",
        "Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;",
        "imageHelper",
        "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;",
        "onBarcodeScanned",
        "Lkotlin/Function1;",
        "",
        "",
        "onScanningError",
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
        "(Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V",
        "isPortrait",
        "",
        "()Z",
        "setPortrait",
        "(Z)V",
        "analyze",
        "image",
        "Landroidx/camera/core/ImageProxy;",
        "cropBitmap",
        "Landroid/graphics/Bitmap;",
        "bitmap",
        "Companion",
        "OSBarcodeLib_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final $stable:I

.field public static final Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$Companion;

.field private static final LOG_TAG:Ljava/lang/String; = "OSBARCBarcodeAnalyzer"


# instance fields
.field private final imageHelper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;

.field private isPortrait:Z

.field private final onBarcodeScanned:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private final onScanningError:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private final scanLibrary:Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$Companion;

    const/16 v0, 0x8

    sput v0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->$stable:I

    return-void
.end method

.method public constructor <init>(Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;",
            "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "scanLibrary"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "imageHelper"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onBarcodeScanned"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onScanningError"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->scanLibrary:Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->imageHelper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;

    iput-object p3, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->onBarcodeScanned:Lkotlin/jvm/functions/Function1;

    iput-object p4, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->onScanningError:Lkotlin/jvm/functions/Function1;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->isPortrait:Z

    return-void
.end method

.method public static final synthetic access$getOnBarcodeScanned$p(Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;)Lkotlin/jvm/functions/Function1;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->onBarcodeScanned:Lkotlin/jvm/functions/Function1;

    return-object p0
.end method

.method public static final synthetic access$getOnScanningError$p(Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;)Lkotlin/jvm/functions/Function1;
    .locals 0

    .line 17
    iget-object p0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->onScanningError:Lkotlin/jvm/functions/Function1;

    return-object p0
.end method

.method private final cropBitmap(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;
    .locals 8

    iget-boolean v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->isPortrait:Z

    const-wide v1, 0x3fe3333333333333L    # 0.6

    if-eqz v0, :cond_0

    .line 69
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    int-to-double v3, v0

    mul-double/2addr v3, v1

    double-to-int v0, v3

    move v6, v0

    move v7, v6

    goto :goto_0

    .line 72
    :cond_0
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    int-to-double v3, v0

    mul-double/2addr v3, v1

    double-to-int v0, v3

    .line 73
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    int-to-double v1, v1

    const-wide/high16 v3, 0x3fe0000000000000L    # 0.5

    mul-double/2addr v1, v3

    double-to-int v1, v1

    move v6, v0

    move v7, v1

    .line 76
    :goto_0
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    sub-int/2addr v0, v6

    div-int/lit8 v4, v0, 0x2

    .line 77
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    sub-int/2addr v0, v7

    div-int/lit8 v5, v0, 0x2

    iget-object v2, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->imageHelper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;

    move-object v3, p1

    .line 79
    invoke-interface/range {v2 .. v7}, Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;->createSubsetBitmapFromSource(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public analyze(Landroidx/camera/core/ImageProxy;)V
    .locals 4

    const-string v0, "image"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    :try_start_0
    iget-object v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->scanLibrary:Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;

    .line 40
    invoke-interface {p1}, Landroidx/camera/core/ImageProxy;->toBitmap()Landroid/graphics/Bitmap;

    move-result-object v1

    const-string v2, "toBitmap(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v1}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->cropBitmap(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 38
    new-instance v2, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$1;

    invoke-direct {v2, p0}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$1;-><init>(Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;)V

    check-cast v2, Lkotlin/jvm/functions/Function1;

    new-instance v3, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$2;

    invoke-direct {v3, p0}, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer$analyze$2;-><init>(Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;)V

    check-cast v3, Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, p1, v1, v2, v3}, Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;->scanBarcode(Landroidx/camera/core/ImageProxy;Landroid/graphics/Bitmap;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 49
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "OSBARCBarcodeAnalyzer"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    iget-object v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->onScanningError:Lkotlin/jvm/functions/Function1;

    .line 50
    sget-object v1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 52
    :goto_0
    invoke-interface {p1}, Landroidx/camera/core/ImageProxy;->close()V

    return-void
.end method

.method public final isPortrait()Z
    .locals 1

    iget-boolean v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->isPortrait:Z

    return v0
.end method

.method public final setPortrait(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCBarcodeAnalyzer;->isPortrait:Z

    return-void
.end method
