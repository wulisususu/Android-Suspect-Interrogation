.class final Lanetwork/channel/cookie/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/cookie/b;->a:Ljava/lang/String;

    .line 156
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 159
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->b()Lanetwork/channel/cookie/CookieManager$a;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lanetwork/channel/cookie/b;->a:Ljava/lang/String;

    .line 164
    invoke-static {v0}, Ljava/net/HttpCookie;->parse(Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/net/HttpCookie;

    .line 165
    invoke-virtual {v1}, Ljava/net/HttpCookie;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->b()Lanetwork/channel/cookie/CookieManager$a;

    move-result-object v3

    iget-object v3, v3, Lanetwork/channel/cookie/CookieManager$a;->a:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 166
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->b()Lanetwork/channel/cookie/CookieManager$a;

    move-result-object v0

    invoke-virtual {v1}, Ljava/net/HttpCookie;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lanetwork/channel/cookie/CookieManager$a;->b:Ljava/lang/String;

    .line 167
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->b()Lanetwork/channel/cookie/CookieManager$a;

    move-result-object v0

    invoke-virtual {v1}, Ljava/net/HttpCookie;->getDomain()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanetwork/channel/cookie/CookieManager$a;->d:Ljava/lang/String;

    .line 168
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->b()Lanetwork/channel/cookie/CookieManager$a;

    move-result-object v0

    iget-object v1, p0, Lanetwork/channel/cookie/b;->a:Ljava/lang/String;

    iput-object v1, v0, Lanetwork/channel/cookie/CookieManager$a;->c:Ljava/lang/String;

    .line 169
    invoke-static {}, Lanetwork/channel/cookie/CookieManager;->b()Lanetwork/channel/cookie/CookieManager$a;

    move-result-object v0

    invoke-virtual {v0}, Lanetwork/channel/cookie/CookieManager$a;->a()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.CookieManager"

    const-string v3, "cookieMonitorSave error."

    const/4 v4, 0x0

    .line 174
    invoke-static {v2, v3, v4, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_2
    :goto_0
    return-void
.end method
