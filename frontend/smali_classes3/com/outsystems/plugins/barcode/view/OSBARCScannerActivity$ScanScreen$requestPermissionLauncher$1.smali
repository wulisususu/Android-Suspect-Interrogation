.class final Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;
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
        "Ljava/lang/Boolean;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "isGranted",
        "",
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
.field final synthetic $permissionGiven$delegate:Landroidx/compose/runtime/MutableState;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/compose/runtime/MutableState<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;


# direct methods
.method constructor <init>(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Landroidx/compose/runtime/MutableState;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;",
            "Landroidx/compose/runtime/MutableState<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->$permissionGiven$delegate:Landroidx/compose/runtime/MutableState;

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 229
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    invoke-virtual {p0, p1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->invoke(Z)V

    sget-object p1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object p1
.end method

.method public final invoke(Z)V
    .locals 2

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->$permissionGiven$delegate:Landroidx/compose/runtime/MutableState;

    .line 233
    invoke-static {p1, v0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$ScanScreen$lambda$2(Landroidx/compose/runtime/MutableState;Z)V

    iget-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 234
    invoke-static {p1, v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$setShowDialog(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Z)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->$permissionGiven$delegate:Landroidx/compose/runtime/MutableState;

    .line 236
    invoke-static {p1, v1}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$ScanScreen$lambda$2(Landroidx/compose/runtime/MutableState;Z)V

    iget-object p1, p0, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity$ScanScreen$requestPermissionLauncher$1;->this$0:Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;

    .line 237
    invoke-static {p1, v0}, Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;->access$setShowDialog(Lcom/outsystems/plugins/barcode/view/OSBARCScannerActivity;Z)V

    :goto_0
    return-void
.end method
