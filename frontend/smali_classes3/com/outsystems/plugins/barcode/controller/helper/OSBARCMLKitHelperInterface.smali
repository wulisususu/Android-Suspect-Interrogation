.class public interface abstract Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;
.super Ljava/lang/Object;
.source "OSBARCMLKitHelperInterface.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008\u00e6\u0080\u0001\u0018\u00002\u00020\u0001J@\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0018\u0010\u0008\u001a\u0014\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u000b0\n\u0012\u0004\u0012\u00020\u00030\t2\u000c\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u00030\rH&\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;",
        "",
        "decodeImage",
        "",
        "imageProxy",
        "Landroidx/camera/core/ImageProxy;",
        "imageBitmap",
        "Landroid/graphics/Bitmap;",
        "onSuccess",
        "Lkotlin/Function1;",
        "",
        "Lcom/google/mlkit/vision/barcode/common/Barcode;",
        "onError",
        "Lkotlin/Function0;",
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


# virtual methods
.method public abstract decodeImage(Landroidx/camera/core/ImageProxy;Landroid/graphics/Bitmap;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function0;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroidx/camera/core/ImageProxy;",
            "Landroid/graphics/Bitmap;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/util/List<",
            "Lcom/google/mlkit/vision/barcode/common/Barcode;",
            ">;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method
