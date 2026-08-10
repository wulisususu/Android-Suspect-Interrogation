.class final Lcom/taobao/agoo/TaobaoRegister$5;
.super Lcom/taobao/agoo/ICallback;
.source "Taobao"


# instance fields
.field final synthetic val$callback:Lcom/taobao/agoo/ICallback;

.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Lcom/taobao/agoo/ICallback;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    iput-object p2, p0, Lcom/taobao/agoo/TaobaoRegister$5;->val$context:Landroid/content/Context;

    .line 524
    invoke-direct {p0}, Lcom/taobao/agoo/ICallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$5;->val$context:Landroid/content/Context;

    .line 532
    new-instance p2, Lcom/taobao/agoo/TaobaoRegister$5$1;

    invoke-direct {p2, p0}, Lcom/taobao/agoo/TaobaoRegister$5$1;-><init>(Lcom/taobao/agoo/TaobaoRegister$5;)V

    new-instance v0, Lcom/taobao/agoo/TaobaoRegister$c;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/agoo/TaobaoRegister$c;-><init>(Lcom/taobao/agoo/c;)V

    const-string v1, "listAlias"

    invoke-static {v1, p1, p2, v0}, Lcom/taobao/agoo/TaobaoRegister;->access$300(Ljava/lang/String;Landroid/content/Context;Lcom/taobao/agoo/ICallback;Lcom/taobao/agoo/TaobaoRegister$b;)V

    return-void
.end method

.method public onSuccess()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    .line 527
    invoke-virtual {v0}, Lcom/taobao/agoo/ICallback;->onSuccess()V

    return-void
.end method
