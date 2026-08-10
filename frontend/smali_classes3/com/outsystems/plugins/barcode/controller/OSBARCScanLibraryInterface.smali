.class public interface abstract Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;
.super Ljava/lang/Object;
.source "OSBARCScanLibraryInterface.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008\u00e6\u0080\u0001\u0018\u00002\u00020\u0001J@\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0012\u0010\u0008\u001a\u000e\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\u00030\t2\u0012\u0010\u000b\u001a\u000e\u0012\u0004\u0012\u00020\u000c\u0012\u0004\u0012\u00020\u00030\tH&\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;",
        "",
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
.method public abstract scanBarcode(Landroidx/camera/core/ImageProxy;Landroid/graphics/Bitmap;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
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
.end method
