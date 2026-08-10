.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;
.super Lkotlin/jvm/internal/Lambda;
.source "OSBARCScannerActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Landroidx/compose/runtime/Composer;",
        "Ljava/lang/Integer;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u0001H\u000b\u00a2\u0006\u0004\u0008\u0002\u0010\u0003"
    }
    d2 = {
        "<anonymous>",
        "",
        "invoke",
        "(Landroidx/compose/runtime/Composer;I)V"
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
.field final synthetic $parameters:Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

.field final synthetic this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;)V
    .locals 0

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;->$parameters:Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    const/4 p1, 0x2

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 192
    check-cast p1, Landroidx/compose/runtime/Composer;

    check-cast p2, Ljava/lang/Number;

    invoke-virtual {p2}, Ljava/lang/Number;->intValue()I

    move-result p2

    invoke-virtual {p0, p1, p2}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;->invoke(Landroidx/compose/runtime/Composer;I)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Landroidx/compose/runtime/Composer;I)V
    .locals 6

    and-int/lit8 v0, p2, 0xb

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    .line 196
    invoke-interface {p1}, Landroidx/compose/runtime/Composer;->getSkipping()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 200
    :cond_0
    invoke-interface {p1}, Landroidx/compose/runtime/Composer;->skipToGroupEnd()V

    goto :goto_1

    .line 196
    :cond_1
    :goto_0
    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->isTraceInProgress()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, -0x1

    const-string v1, "com.outsystems.plugins.barcode.view.OSBARCScannerActivity.onCreate.<anonymous> (OSBARCScannerActivity.kt:195)"

    const v2, -0x3de25508

    invoke-static {v2, p2, v0, v1}, Landroidx/compose/runtime/ComposerKt;->traceEventStart(IIILjava/lang/String;)V

    :cond_2
    iget-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    check-cast p2, Landroid/app/Activity;

    const/16 v0, 0x8

    invoke-static {p2, p1, v0}, Landroidx/compose/material3/windowsizeclass/AndroidWindowSizeClass_androidKt;->calculateWindowSizeClass(Landroid/app/Activity;Landroidx/compose/runtime/Composer;I)Landroidx/compose/material3/windowsizeclass/WindowSizeClass;

    move-result-object p2

    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 198
    new-instance v2, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3$1;

    iget-object v3, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iget-object v4, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3;->$parameters:Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    invoke-direct {v2, v3, v4, p2}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$onCreate$3$1;-><init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;Landroidx/compose/material3/windowsizeclass/WindowSizeClass;)V

    const p2, 0x44e3dd1a

    const/4 v3, 0x1

    invoke-static {p1, p2, v3, v2}, Landroidx/compose/runtime/internal/ComposableLambdaKt;->composableLambda(Landroidx/compose/runtime/Composer;IZLjava/lang/Object;)Landroidx/compose/runtime/internal/ComposableLambda;

    move-result-object p2

    move-object v2, p2

    check-cast v2, Lkotlin/jvm/functions/Function2;

    const/16 v4, 0x180

    const/4 v5, 0x3

    move-object v3, p1

    invoke-static/range {v0 .. v5}, Lcom/outsystems/plugins/barcode/view/ui/theme/ThemeKt;->BarcodeScannerTheme(ZZLkotlin/jvm/functions/Function2;Landroidx/compose/runtime/Composer;II)V

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->isTraceInProgress()Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-static {}, Landroidx/compose/runtime/ComposerKt;->traceEventEnd()V

    :cond_3
    :goto_1
    return-void
.end method
