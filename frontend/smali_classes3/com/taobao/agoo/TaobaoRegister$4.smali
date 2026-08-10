.class final Lcom/taobao/agoo/TaobaoRegister$4;
.super Lcom/taobao/agoo/IListAliasCallbackInner;
.source "Taobao"


# instance fields
.field final synthetic val$alias:Ljava/lang/String;

.field final synthetic val$callback:Lcom/taobao/agoo/ICallback;

.field final synthetic val$context:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/taobao/agoo/ICallback;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$context:Landroid/content/Context;

    iput-object p2, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$callback:Lcom/taobao/agoo/ICallback;

    iput-object p3, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$alias:Ljava/lang/String;

    .line 472
    invoke-direct {p0}, Lcom/taobao/agoo/IListAliasCallbackInner;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$callback:Lcom/taobao/agoo/ICallback;

    iget-object p2, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$alias:Ljava/lang/String;

    .line 492
    iput-object p2, p1, Lcom/taobao/agoo/ICallback;->extra:Ljava/lang/String;

    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$context:Landroid/content/Context;

    iget-object p2, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$callback:Lcom/taobao/agoo/ICallback;

    .line 493
    new-instance v0, Lcom/taobao/agoo/TaobaoRegister$a;

    iget-object v1, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$alias:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/taobao/agoo/TaobaoRegister$a;-><init>(Ljava/lang/String;Lcom/taobao/agoo/c;)V

    const-string v1, "setAlias"

    invoke-static {v1, p1, p2, v0}, Lcom/taobao/agoo/TaobaoRegister;->access$300(Ljava/lang/String;Landroid/content/Context;Lcom/taobao/agoo/ICallback;Lcom/taobao/agoo/TaobaoRegister$b;)V

    return-void
.end method

.method public onSuccess(Ljava/util/Map;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$4;->val$context:Landroid/content/Context;

    .line 475
    new-instance v1, Lcom/taobao/agoo/TaobaoRegister$4$1;

    invoke-direct {v1, p0}, Lcom/taobao/agoo/TaobaoRegister$4$1;-><init>(Lcom/taobao/agoo/TaobaoRegister$4;)V

    invoke-static {v0, p1, v1}, Lcom/taobao/agoo/TaobaoRegister;->access$400(Landroid/content/Context;Ljava/util/Map;Lcom/taobao/agoo/ICallback;)V

    return-void
.end method
