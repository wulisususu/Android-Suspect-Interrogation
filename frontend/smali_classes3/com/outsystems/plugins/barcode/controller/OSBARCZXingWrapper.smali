.class public final Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;
.super Ljava/lang/Object;
.source "OSBARCZXingWrapper.kt"

# interfaces
.implements Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOSBARCZXingWrapper.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OSBARCZXingWrapper.kt\ncom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,68:1\n1#2:69\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0007\u0018\u0000 \u00102\u00020\u0001:\u0001\u0010B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J@\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0012\u0010\u000b\u001a\u000e\u0012\u0004\u0012\u00020\r\u0012\u0004\u0012\u00020\u00060\u000c2\u0012\u0010\u000e\u001a\u000e\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u00060\u000cH\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;",
        "Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;",
        "helper",
        "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;",
        "(Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;)V",
        "scanBarcode",
        "",
        "imageProxy",
        "Landroidx/camera/core/ImageProxy;",
        "imageBitmap",
        "Landroid/graphics/Bitmap;",
        "onSuccess",
        "Lkotlin/Function1;",
        "",
        "onError",
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
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

.field public static final Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$Companion;

.field private static final LOG_TAG:Ljava/lang/String; = "OSBARCZXingWrapper"


# instance fields
.field private final helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;->Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$Companion;

    const/16 v0, 0x8

    sput v0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;->$stable:I

    return-void
.end method

.method public constructor <init>(Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;)V
    .locals 1

    const-string v0, "helper"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;->helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;

    return-void
.end method


# virtual methods
.method public scanBarcode(Landroidx/camera/core/ImageProxy;Landroid/graphics/Bitmap;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/camera/core/ImageProxy;",
            "Landroid/graphics/Bitmap;",
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

    const-string v0, "imageProxy"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "imageBitmap"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onSuccess"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onError"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 35
    :try_start_0
    invoke-interface {p1}, Landroidx/camera/core/ImageProxy;->getImageInfo()Landroidx/camera/core/ImageInfo;

    move-result-object p1

    invoke-interface {p1}, Landroidx/camera/core/ImageInfo;->getRotationDegrees()I

    move-result p1

    const/16 v0, 0x5a

    if-eq p1, v0, :cond_0

    const/16 v0, 0x10e

    if-eq p1, v0, :cond_0

    :goto_0
    move-object v0, p2

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;->helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;

    .line 37
    invoke-interface {v0, p2, p1}, Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;->rotateBitmap(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object p2

    goto :goto_0

    .line 41
    :goto_1
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p1

    .line 42
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p2

    mul-int v1, p1, p2

    .line 43
    new-array v8, v1, [I

    const/4 v2, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, v8

    move v3, p1

    move v6, p1

    move v7, p2

    .line 44
    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper;->helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;

    .line 54
    new-instance v0, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$scanBarcode$1;

    invoke-direct {v0, p3}, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$scanBarcode$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    move-object v5, v0

    check-cast v5, Lkotlin/jvm/functions/Function1;

    new-instance p3, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$scanBarcode$2;

    invoke-direct {p3, p4}, Lcom/outsystems/plugins/barcode/controller/OSBARCZXingWrapper$scanBarcode$2;-><init>(Lkotlin/jvm/functions/Function1;)V

    move-object v6, p3

    check-cast v6, Lkotlin/jvm/functions/Function0;

    move-object v2, v8

    move v3, p1

    move v4, p2

    invoke-interface/range {v1 .. v6}, Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;->decodeImage([IIILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function0;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    .line 63
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_1

    const-string p2, "OSBARCZXingWrapper"

    invoke-static {p2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 64
    :cond_1
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->ZXING_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p4, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_2
    return-void
.end method
