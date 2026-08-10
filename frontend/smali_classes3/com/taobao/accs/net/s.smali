.class Lcom/taobao/accs/net/s;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/RequestCb;


# instance fields
.field final synthetic a:Lanet/channel/IAuth$AuthCallback;

.field final synthetic b:Lcom/taobao/accs/net/j$a;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/j$a;Lanet/channel/IAuth$AuthCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    iput-object p2, p0, Lcom/taobao/accs/net/s;->a:Lanet/channel/IAuth$AuthCallback;

    .line 710
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDataReceive(Lanet/channel/bytes/ByteArray;Z)V
    .locals 0

    return-void
.end method

.method public onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 2

    if-gez p1, :cond_0

    iget-object p2, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 741
    invoke-static {p2}, Lcom/taobao/accs/net/j$a;->a(Lcom/taobao/accs/net/j$a;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object p2

    const-string p3, "statusCode"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, "auth onFinish"

    filled-new-array {v1, p3, v0}, [Ljava/lang/Object;

    move-result-object p3

    invoke-interface {p2, p3}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    iget-object p2, p0, Lcom/taobao/accs/net/s;->a:Lanet/channel/IAuth$AuthCallback;

    const-string p3, "onFinish auth fail"

    .line 742
    invoke-interface {p2, p1, p3}, Lanet/channel/IAuth$AuthCallback;->onAuthFail(ILjava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onResponseCode(ILjava/util/Map;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    .line 713
    invoke-static {p2}, Lcom/taobao/accs/utl/UtilityImpl;->a(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p2

    iget-object v0, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 714
    invoke-static {v0}, Lcom/taobao/accs/net/j$a;->a(Lcom/taobao/accs/net/j$a;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    const-string v1, "header"

    const-string v2, "auth"

    filled-new-array {v2, v1, p2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d([Ljava/lang/Object;)V

    const-string v0, "x-at"

    .line 715
    invoke-interface {p2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 716
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 717
    invoke-static {v1}, Lcom/taobao/accs/net/j$a;->b(Lcom/taobao/accs/net/j$a;)Lcom/taobao/accs/net/b;

    move-result-object v1

    iput-object v0, v1, Lcom/taobao/accs/net/b;->k:Ljava/lang/String;

    :cond_0
    const/16 v0, 0xc8

    const-string v1, "httpStatusCode"

    if-ne p1, v0, :cond_1

    iget-object p2, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 720
    invoke-static {p2}, Lcom/taobao/accs/net/j$a;->a(Lcom/taobao/accs/net/j$a;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object p2

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    filled-new-array {v2, v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-interface {p2, p1}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/accs/net/s;->a:Lanet/channel/IAuth$AuthCallback;

    .line 721
    invoke-interface {p1}, Lanet/channel/IAuth$AuthCallback;->onAuthSuccess()V

    iget-object p1, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 722
    invoke-static {p1}, Lcom/taobao/accs/net/j$a;->b(Lcom/taobao/accs/net/j$a;)Lcom/taobao/accs/net/b;

    move-result-object p1

    instance-of p1, p1, Lcom/taobao/accs/net/j;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 723
    invoke-static {p1}, Lcom/taobao/accs/net/j$a;->b(Lcom/taobao/accs/net/j$a;)Lcom/taobao/accs/net/b;

    move-result-object p1

    check-cast p1, Lcom/taobao/accs/net/j;

    invoke-static {p1}, Lcom/taobao/accs/net/j;->c(Lcom/taobao/accs/net/j;)V

    goto :goto_0

    :cond_1
    const-string v0, "s-accs-retcode"

    .line 726
    invoke-interface {p2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/accs/net/s;->b:Lcom/taobao/accs/net/j$a;

    .line 727
    invoke-static {v0}, Lcom/taobao/accs/net/j$a;->a(Lcom/taobao/accs/net/j$a;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v2, v1, v3}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 728
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "auth fail "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string v1, "re"

    invoke-virtual {v0, v1, p2}, Lcom/taobao/accs/AccsState;->b(Ljava/lang/String;Ljava/lang/Object;)V

    iget-object p2, p0, Lcom/taobao/accs/net/s;->a:Lanet/channel/IAuth$AuthCallback;

    const-string v0, "auth fail"

    .line 730
    invoke-interface {p2, p1, v0}, Lanet/channel/IAuth$AuthCallback;->onAuthFail(ILjava/lang/String;)V

    :cond_2
    :goto_0
    return-void
.end method
