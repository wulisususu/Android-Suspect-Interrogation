.class public interface abstract Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;
.super Ljava/lang/Object;
.source "OSBARCImageHelperInterface.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0004\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J0\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00032\u0006\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\t2\u0006\u0010\u000b\u001a\u00020\t2\u0006\u0010\u000c\u001a\u00020\tH&\u00a8\u0006\r"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCImageHelperInterface;",
        "",
        "bitmapFromImageBytes",
        "Landroid/graphics/Bitmap;",
        "imageBytes",
        "",
        "createSubsetBitmapFromSource",
        "source",
        "rectLeft",
        "",
        "rectTop",
        "rectWidth",
        "rectHeight",
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
.method public abstract bitmapFromImageBytes([B)Landroid/graphics/Bitmap;
.end method

.method public abstract createSubsetBitmapFromSource(Landroid/graphics/Bitmap;IIII)Landroid/graphics/Bitmap;
.end method
