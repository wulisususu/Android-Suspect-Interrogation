.class public final Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper;
.super Ljava/lang/Object;
.source "OSBARCMLKitWrapper.kt"

# interfaces
.implements Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nOSBARCMLKitWrapper.kt\nKotlin\n*S Kotlin\n*F\n+ 1 OSBARCMLKitWrapper.kt\ncom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,52:1\n1#2:53\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00006\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0007\u0018\u0000 \u00102\u00020\u0001:\u0001\u0010B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J@\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\n2\u0012\u0010\u000b\u001a\u000e\u0012\u0004\u0012\u00020\r\u0012\u0004\u0012\u00020\u00060\u000c2\u0012\u0010\u000e\u001a\u000e\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u00060\u000cH\u0016R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper;",
        "Lcom/outsystems/plugins/barcode/controller/OSBARCScanLibraryInterface;",
        "helper",
        "Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;",
        "(Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;)V",
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

.field public static final Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$Companion;

.field private static final LOG_TAG:Ljava/lang/String; = "OSBARCMLKitWrapper"


# instance fields
.field private final helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper;->Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$Companion;

    const/16 v0, 0x8

    sput v0, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper;->$stable:I

    return-void
.end method

.method public constructor <init>(Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;)V
    .locals 1

    const-string v0, "helper"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper;->helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;

    return-void
.end method


# virtual methods
.method public scanBarcode(Landroidx/camera/core/ImageProxy;Landroid/graphics/Bitmap;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 2
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

    :try_start_0
    iget-object v0, p0, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper;->helper:Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;

    .line 32
    new-instance v1, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$scanBarcode$1;

    invoke-direct {v1, p3}, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$scanBarcode$1;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast v1, Lkotlin/jvm/functions/Function1;

    new-instance p3, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$scanBarcode$2;

    invoke-direct {p3, p4}, Lcom/outsystems/plugins/barcode/controller/OSBARCMLKitWrapper$scanBarcode$2;-><init>(Lkotlin/jvm/functions/Function1;)V

    check-cast p3, Lkotlin/jvm/functions/Function0;

    invoke-interface {v0, p1, p2, v1, p3}, Lcom/outsystems/plugins/barcode/controller/helper/OSBARCMLKitHelperInterface;->decodeImage(Landroidx/camera/core/ImageProxy;Landroid/graphics/Bitmap;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function0;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 47
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string p2, "OSBARCMLKitWrapper"

    invoke-static {p2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 48
    :cond_0
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->MLKIT_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p4, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void
.end method
