.class public final Lcom/outsystems/plugins/barcode/controller/OSBARCController;
.super Ljava/lang/Object;
.source "OSBARCController.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/outsystems/plugins/barcode/controller/OSBARCController$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000@\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0007\u0018\u0000 \u00142\u00020\u0001:\u0001\u0014B\u0005\u00a2\u0006\u0002\u0010\u0002JH\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00062\u0008\u0010\u0008\u001a\u0004\u0018\u00010\t2\u0012\u0010\n\u001a\u000e\u0012\u0004\u0012\u00020\u000c\u0012\u0004\u0012\u00020\u00040\u000b2\u0012\u0010\r\u001a\u000e\u0012\u0004\u0012\u00020\u000e\u0012\u0004\u0012\u00020\u00040\u000bJ\u0016\u0010\u000f\u001a\u00020\u00042\u0006\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0012\u001a\u00020\u0013\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/controller/OSBARCController;",
        "",
        "()V",
        "handleActivityResult",
        "",
        "requestCode",
        "",
        "resultCode",
        "intent",
        "Landroid/content/Intent;",
        "onSuccess",
        "Lkotlin/Function1;",
        "",
        "onError",
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
        "scanCode",
        "activity",
        "Landroid/app/Activity;",
        "parameters",
        "Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;",
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
.field public static final $stable:I = 0x0

.field public static final Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCController$Companion;

.field private static final LOG_TAG:Ljava/lang/String; = "OSBARCController"

.field private static final SCAN_PARAMETERS:Ljava/lang/String; = "SCAN_PARAMETERS"

.field private static final SCAN_REQUEST_CODE:I = 0x70

.field private static final SCAN_RESULT:Ljava/lang/String; = "scanResult"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/outsystems/plugins/barcode/controller/OSBARCController$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/outsystems/plugins/barcode/controller/OSBARCController$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/controller/OSBARCController;->Companion:Lcom/outsystems/plugins/barcode/controller/OSBARCController$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final handleActivityResult(IILandroid/content/Intent;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(II",
            "Landroid/content/Intent;",
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

    const-string v0, "onSuccess"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onError"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v0, 0x70

    const-string v1, "OSBARCController"

    if-ne p1, v0, :cond_a

    const/4 p1, -0x1

    if-ne p2, p1, :cond_3

    if-eqz p3, :cond_0

    .line 56
    invoke-virtual {p3}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string p2, "scanResult"

    invoke-virtual {p1, p2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 57
    :goto_0
    move-object p2, p1

    check-cast p2, Ljava/lang/CharSequence;

    if-eqz p2, :cond_2

    invoke-interface {p2}, Ljava/lang/CharSequence;->length()I

    move-result p2

    if-nez p2, :cond_1

    goto :goto_1

    .line 61
    :cond_1
    invoke-interface {p4, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto/16 :goto_2

    .line 58
    :cond_2
    :goto_1
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    :cond_3
    if-nez p2, :cond_4

    .line 64
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCAN_CANCELLED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 65
    :cond_4
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCAN_CANCELLED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result p1

    if-ne p2, p1, :cond_5

    .line 66
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCAN_CANCELLED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 67
    :cond_5
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->CAMERA_PERMISSION_DENIED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result p1

    if-ne p2, p1, :cond_6

    .line 68
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->CAMERA_PERMISSION_DENIED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 69
    :cond_6
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result p1

    if-ne p2, p1, :cond_7

    .line 70
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 71
    :cond_7
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->ZXING_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result p1

    if-ne p2, p1, :cond_8

    .line 72
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->ZXING_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 73
    :cond_8
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->MLKIT_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {p1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->getCode()I

    move-result p1

    if-ne p2, p1, :cond_9

    .line 74
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->MLKIT_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_9
    const-string p1, "Invalid result code"

    .line 76
    invoke-static {v1, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 77
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_a
    const-string p1, "Invalid request code"

    .line 82
    invoke-static {v1, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    sget-object p1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-interface {p5, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_2
    return-void
.end method

.method public final scanCode(Landroid/app/Activity;Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;)V
    .locals 3

    const-string v0, "activity"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "parameters"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 31
    new-instance v0, Landroid/content/Intent;

    .line 32
    move-object v1, p1

    check-cast v1, Landroid/content/Context;

    const-class v2, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 31
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "SCAN_PARAMETERS"

    .line 33
    check-cast p2, Ljava/io/Serializable;

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    move-result-object p2

    const/16 v0, 0x70

    .line 30
    invoke-virtual {p1, p2, v0}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method
