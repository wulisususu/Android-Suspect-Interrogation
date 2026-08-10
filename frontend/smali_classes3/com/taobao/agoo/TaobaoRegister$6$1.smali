.class Lcom/taobao/agoo/TaobaoRegister$6$1;
.super Lcom/taobao/agoo/IListAliasCallbackInner;
.source "Taobao"


# instance fields
.field final synthetic this$0:Lcom/taobao/agoo/TaobaoRegister$6;

.field final synthetic val$errCode:Ljava/lang/String;

.field final synthetic val$errDesc:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/agoo/TaobaoRegister$6;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    iput-object p2, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->val$errCode:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->val$errDesc:Ljava/lang/String;

    .line 641
    invoke-direct {p0}, Lcom/taobao/agoo/IListAliasCallbackInner;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    .line 655
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$6;->val$callback:Lcom/taobao/agoo/ICallback;

    invoke-virtual {v0, p1, p2}, Lcom/taobao/agoo/ICallback;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSuccess(Ljava/util/Map;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    .line 644
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$6;->val$alias:Ljava/lang/String;

    invoke-interface {p1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    .line 646
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$6;->val$context:Landroid/content/Context;

    iget-object v1, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    iget-object v1, v1, Lcom/taobao/agoo/TaobaoRegister$6;->val$callback:Lcom/taobao/agoo/ICallback;

    new-instance v2, Lcom/taobao/agoo/TaobaoRegister$d;

    iget-object v3, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    iget-object v3, v3, Lcom/taobao/agoo/TaobaoRegister$6;->val$alias:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-direct {v2, v3, p1, v4}, Lcom/taobao/agoo/TaobaoRegister$d;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/agoo/c;)V

    const-string p1, "removeAlias"

    invoke-static {p1, v0, v1, v2}, Lcom/taobao/agoo/TaobaoRegister;->access$300(Ljava/lang/String;Landroid/content/Context;Lcom/taobao/agoo/ICallback;Lcom/taobao/agoo/TaobaoRegister$b;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$6;

    .line 649
    iget-object p1, p1, Lcom/taobao/agoo/TaobaoRegister$6;->val$callback:Lcom/taobao/agoo/ICallback;

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->val$errCode:Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/agoo/TaobaoRegister$6$1;->val$errDesc:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lcom/taobao/agoo/ICallback;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method
