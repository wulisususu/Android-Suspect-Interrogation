.class Lcom/taobao/agoo/TaobaoRegister$5$1;
.super Lcom/taobao/agoo/IListAliasCallbackInner;
.source "Taobao"


# instance fields
.field final synthetic this$0:Lcom/taobao/agoo/TaobaoRegister$5;


# direct methods
.method constructor <init>(Lcom/taobao/agoo/TaobaoRegister$5;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 532
    invoke-direct {p0}, Lcom/taobao/agoo/IListAliasCallbackInner;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 540
    iget-object p1, p1, Lcom/taobao/agoo/TaobaoRegister$5;->val$context:Landroid/content/Context;

    invoke-static {p1}, Lcom/taobao/agoo/b;->a(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 541
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p2

    if-lez p2, :cond_2

    const/4 p2, 0x0

    .line 542
    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 543
    iget-object p2, p2, Lcom/taobao/agoo/TaobaoRegister$5;->val$context:Landroid/content/Context;

    invoke-static {p2, p1}, Lcom/taobao/agoo/b;->a(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_1

    .line 544
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 549
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    iput-object p1, v0, Lcom/taobao/agoo/ICallback;->extra:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 550
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$5;->val$context:Landroid/content/Context;

    iget-object v1, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    iget-object v1, v1, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    new-instance v2, Lcom/taobao/agoo/TaobaoRegister$d;

    const/4 v3, 0x0

    invoke-direct {v2, p1, p2, v3}, Lcom/taobao/agoo/TaobaoRegister$d;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/agoo/c;)V

    const-string p1, "removeAlias"

    invoke-static {p1, v0, v1, v2}, Lcom/taobao/agoo/TaobaoRegister;->access$300(Ljava/lang/String;Landroid/content/Context;Lcom/taobao/agoo/ICallback;Lcom/taobao/agoo/TaobaoRegister$b;)V

    goto :goto_1

    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 545
    iget-object p1, p1, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    sget-object p2, Lcom/taobao/agoo/a;->REMOVE_ALIAS_FAIL_NO_TOKEN:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 546
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p2

    sget-object v0, Lcom/taobao/agoo/a;->REMOVE_ALIAS_FAIL_NO_TOKEN:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 547
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object v0

    .line 545
    invoke-virtual {p1, p2, v0}, Lcom/taobao/agoo/ICallback;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 554
    iget-object p1, p1, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    sget-object p2, Lcom/taobao/agoo/a;->REMOVE_ALIAS_FAIL_NO_ALIAS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p2

    sget-object v0, Lcom/taobao/agoo/a;->REMOVE_ALIAS_FAIL_NO_ALIAS:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 555
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object v0

    .line 554
    invoke-virtual {p1, p2, v0}, Lcom/taobao/agoo/ICallback;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
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

    iget-object v0, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    .line 535
    iget-object v0, v0, Lcom/taobao/agoo/TaobaoRegister$5;->val$context:Landroid/content/Context;

    iget-object v1, p0, Lcom/taobao/agoo/TaobaoRegister$5$1;->this$0:Lcom/taobao/agoo/TaobaoRegister$5;

    iget-object v1, v1, Lcom/taobao/agoo/TaobaoRegister$5;->val$callback:Lcom/taobao/agoo/ICallback;

    invoke-static {v0, p1, v1}, Lcom/taobao/agoo/TaobaoRegister;->access$400(Landroid/content/Context;Ljava/util/Map;Lcom/taobao/agoo/ICallback;)V

    return-void
.end method
