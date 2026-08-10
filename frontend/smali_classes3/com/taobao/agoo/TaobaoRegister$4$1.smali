.class Lcom/taobao/agoo/TaobaoRegister$4$1;
.super Lcom/taobao/agoo/ICallback;
.source "Taobao"


# instance fields
.field final synthetic this$0:Lcom/taobao/agoo/TaobaoRegister$4;


# direct methods
.method constructor <init>(Lcom/taobao/agoo/TaobaoRegister$4;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$4$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$4;

    .line 475
    invoke-direct {p0}, Lcom/taobao/agoo/ICallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$4$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$4;

    .line 484
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$4;->val$callback:Lcom/taobao/agoo/ICallback;

    invoke-virtual {v0, p1, p2}, Lcom/taobao/agoo/ICallback;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSuccess()V
    .locals 5

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$4$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$4;

    .line 478
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$4;->val$context:Landroid/content/Context;

    iget-object v1, p0, Lcom/taobao/agoo/TaobaoRegister$4$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$4;

    iget-object v1, v1, Lcom/taobao/agoo/TaobaoRegister$4;->val$callback:Lcom/taobao/agoo/ICallback;

    new-instance v2, Lcom/taobao/agoo/TaobaoRegister$a;

    iget-object v3, p0, Lcom/taobao/agoo/TaobaoRegister$4$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$4;

    iget-object v3, v3, Lcom/taobao/agoo/TaobaoRegister$4;->val$alias:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v2, v3, v4}, Lcom/taobao/agoo/TaobaoRegister$a;-><init>(Ljava/lang/String;Lcom/taobao/agoo/c;)V

    const-string v3, "setAlias"

    invoke-static {v3, v0, v1, v2}, Lcom/taobao/agoo/TaobaoRegister;->access$300(Ljava/lang/String;Landroid/content/Context;Lcom/taobao/agoo/ICallback;Lcom/taobao/agoo/TaobaoRegister$b;)V

    return-void
.end method
