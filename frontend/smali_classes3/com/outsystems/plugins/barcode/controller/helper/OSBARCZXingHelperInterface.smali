.class public interface abstract Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;
.super Ljava/lang/Object;
.source "OSBARCZXingHelperInterface.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0015\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001JB\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\u00072\u0012\u0010\t\u001a\u000e\u0012\u0004\u0012\u00020\u000b\u0012\u0004\u0012\u00020\u00030\n2\u000c\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u00030\rH&J\u0018\u0010\u000e\u001a\u00020\u000f2\u0006\u0010\u0010\u001a\u00020\u000f2\u0006\u0010\u0011\u001a\u00020\u0007H&\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCZXingHelperInterface;",
        "",
        "decodeImage",
        "",
        "pixels",
        "",
        "width",
        "",
        "height",
        "onSuccess",
        "Lkotlin/Function1;",
        "",
        "onError",
        "Lkotlin/Function0;",
        "rotateBitmap",
        "Landroid/graphics/Bitmap;",
        "bitmap",
        "rotationDegrees",
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
.method public abstract decodeImage([IIILkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function0;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([III",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract rotateBitmap(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;
.end method
