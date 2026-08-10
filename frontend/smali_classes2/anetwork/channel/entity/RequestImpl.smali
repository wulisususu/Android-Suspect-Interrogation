.class public Lanetwork/channel/entity/RequestImpl;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanetwork/channel/Request;


# instance fields
.field private a:Ljava/net/URI;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private b:Ljava/net/URL;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private c:Ljava/lang/String;

.field private d:Z

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lanetwork/channel/Header;",
            ">;"
        }
    .end annotation
.end field

.field private f:Ljava/lang/String;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lanetwork/channel/Param;",
            ">;"
        }
    .end annotation
.end field

.field private h:I

.field private i:Ljava/lang/String;

.field private j:Lanet/channel/request/BodyEntry;

.field private k:I

.field private l:I

.field private m:Ljava/lang/String;

.field private n:Ljava/lang/String;

.field private o:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanetwork/channel/entity/RequestImpl;->d:Z

    const-string v0, "GET"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->f:Ljava/lang/String;

    const/4 v0, 0x2

    iput v0, p0, Lanetwork/channel/entity/RequestImpl;->h:I

    const-string v0, "utf-8"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->i:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanetwork/channel/entity/RequestImpl;->d:Z

    const-string v0, "GET"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->f:Ljava/lang/String;

    const/4 v0, 0x2

    iput v0, p0, Lanetwork/channel/entity/RequestImpl;->h:I

    const-string v0, "utf-8"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->i:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/net/URI;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanetwork/channel/entity/RequestImpl;->d:Z

    const-string v0, "GET"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->f:Ljava/lang/String;

    const/4 v0, 0x2

    iput v0, p0, Lanetwork/channel/entity/RequestImpl;->h:I

    const-string v0, "utf-8"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->i:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->a:Ljava/net/URI;

    .line 47
    invoke-virtual {p1}, Ljava/net/URI;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Ljava/net/URL;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanetwork/channel/entity/RequestImpl;->d:Z

    const-string v0, "GET"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->f:Ljava/lang/String;

    const/4 v0, 0x2

    iput v0, p0, Lanetwork/channel/entity/RequestImpl;->h:I

    const-string v0, "utf-8"

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->i:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->b:Ljava/net/URL;

    .line 53
    invoke-virtual {p1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public addHeader(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    if-eqz p1, :cond_2

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    if-nez v0, :cond_1

    .line 127
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 129
    :cond_1
    new-instance v0, Lanetwork/channel/entity/BasicHeader;

    invoke-direct {v0, p1, p2}, Lanetwork/channel/entity/BasicHeader;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 130
    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    :goto_0
    return-void
.end method

.method public getBizId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->m:Ljava/lang/String;

    return-object v0
.end method

.method public getBodyEntry()Lanet/channel/request/BodyEntry;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    return-object v0
.end method

.method public getBodyHandler()Lanetwork/channel/IBodyHandler;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x0

    return-object v0
.end method

.method public getCharset()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->i:Ljava/lang/String;

    return-object v0
.end method

.method public getConnectTimeout()I
    .locals 1

    iget v0, p0, Lanetwork/channel/entity/RequestImpl;->k:I

    return v0
.end method

.method public getExtProperties()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->o:Ljava/util/Map;

    return-object v0
.end method

.method public getExtProperty(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->o:Ljava/util/Map;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 302
    :cond_0
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    return-object p1
.end method

.method public getFollowRedirects()Z
    .locals 1

    iget-boolean v0, p0, Lanetwork/channel/entity/RequestImpl;->d:Z

    return v0
.end method

.method public getHeaders()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lanetwork/channel/Header;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    return-object v0
.end method

.method public getHeaders(Ljava/lang/String;)[Lanetwork/channel/Header;
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 166
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    if-eqz v2, :cond_3

    const/4 v2, 0x0

    :goto_0
    iget-object v3, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 168
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    iget-object v3, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 169
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lanetwork/channel/Header;

    invoke-interface {v3}, Lanetwork/channel/Header;->getName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lanetwork/channel/Header;

    invoke-interface {v3}, Lanetwork/channel/Header;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 170
    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 173
    :cond_2
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-lez p1, :cond_3

    .line 174
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result p1

    new-array v0, p1, [Lanetwork/channel/Header;

    .line 175
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    :cond_3
    return-object v0
.end method

.method public getMethod()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->f:Ljava/lang/String;

    return-object v0
.end method

.method public getParams()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lanetwork/channel/Param;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->g:Ljava/util/List;

    return-object v0
.end method

.method public getReadTimeout()I
    .locals 1

    iget v0, p0, Lanetwork/channel/entity/RequestImpl;->l:I

    return v0
.end method

.method public getRetryTime()I
    .locals 1

    iget v0, p0, Lanetwork/channel/entity/RequestImpl;->h:I

    return v0
.end method

.method public getSeqNo()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->n:Ljava/lang/String;

    return-object v0
.end method

.method public getURI()Ljava/net/URI;
    .locals 5
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->a:Ljava/net/URI;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 67
    :try_start_0
    new-instance v0, Ljava/net/URI;

    iget-object v1, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->a:Ljava/net/URI;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lanetwork/channel/entity/RequestImpl;->n:Ljava/lang/String;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "anet.RequestImpl"

    const-string v4, "uri error"

    .line 69
    invoke-static {v3, v4, v1, v0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->a:Ljava/net/URI;

    return-object v0
.end method

.method public getURL()Ljava/net/URL;
    .locals 5
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->b:Ljava/net/URL;

    if-eqz v0, :cond_0

    return-object v0

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 87
    :try_start_0
    new-instance v0, Ljava/net/URL;

    iget-object v1, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->b:Ljava/net/URL;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    iget-object v1, p0, Lanetwork/channel/entity/RequestImpl;->n:Ljava/lang/String;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "anet.RequestImpl"

    const-string v4, "url error"

    .line 89
    invoke-static {v3, v4, v1, v0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->b:Ljava/net/URL;

    return-object v0
.end method

.method public getUrlString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    return-object v0
.end method

.method public isCookieEnabled()Z
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-string v0, "EnableCookie"

    .line 277
    invoke-virtual {p0, v0}, Lanetwork/channel/entity/RequestImpl;->getExtProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "false"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public removeHeader(Lanetwork/channel/Header;)V
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 135
    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public setBizId(I)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 252
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->m:Ljava/lang/String;

    return-void
.end method

.method public setBizId(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->m:Ljava/lang/String;

    return-void
.end method

.method public setBodyEntry(Lanet/channel/request/BodyEntry;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    return-void
.end method

.method public setBodyHandler(Lanetwork/channel/IBodyHandler;)V
    .locals 1

    .line 229
    new-instance v0, Lanetwork/channel/entity/BodyHandlerEntry;

    invoke-direct {v0, p1}, Lanetwork/channel/entity/BodyHandlerEntry;-><init>(Lanetwork/channel/IBodyHandler;)V

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->j:Lanet/channel/request/BodyEntry;

    return-void
.end method

.method public setCharset(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->i:Ljava/lang/String;

    return-void
.end method

.method public setConnectTimeout(I)V
    .locals 0

    iput p1, p0, Lanetwork/channel/entity/RequestImpl;->k:I

    return-void
.end method

.method public setCookieEnabled(Z)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    if-eqz p1, :cond_0

    const-string p1, "true"

    goto :goto_0

    :cond_0
    const-string p1, "false"

    :goto_0
    const-string v0, "EnableCookie"

    .line 285
    invoke-virtual {p0, v0, p1}, Lanetwork/channel/entity/RequestImpl;->setExtProperty(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public setExtProperty(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 289
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->o:Ljava/util/Map;

    if-nez v0, :cond_1

    .line 293
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->o:Ljava/util/Map;

    :cond_1
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->o:Ljava/util/Map;

    .line 295
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public setFollowRedirects(Z)V
    .locals 0

    iput-boolean p1, p0, Lanetwork/channel/entity/RequestImpl;->d:Z

    return-void
.end method

.method public setHeader(Lanetwork/channel/Header;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    if-nez v0, :cond_1

    .line 144
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 147
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_3

    iget-object v2, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 149
    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanetwork/channel/Header;

    invoke-interface {v2}, Lanetwork/channel/Header;->getName()Ljava/lang/String;

    move-result-object v2

    .line 150
    invoke-interface {p1}, Lanetwork/channel/Header;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 151
    invoke-interface {v0, v1, p1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    :goto_1
    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 155
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v1, v0, :cond_4

    iget-object v0, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    .line 156
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    return-void
.end method

.method public setHeaders(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lanetwork/channel/Header;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->e:Ljava/util/List;

    return-void
.end method

.method public setMethod(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->f:Ljava/lang/String;

    return-void
.end method

.method public setParams(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lanetwork/channel/Param;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->g:Ljava/util/List;

    return-void
.end method

.method public setReadTimeout(I)V
    .locals 0

    iput p1, p0, Lanetwork/channel/entity/RequestImpl;->l:I

    return-void
.end method

.method public setRetryTime(I)V
    .locals 0

    iput p1, p0, Lanetwork/channel/entity/RequestImpl;->h:I

    return-void
.end method

.method public setSeqNo(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->n:Ljava/lang/String;

    return-void
.end method

.method public setUrL(Ljava/net/URL;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->b:Ljava/net/URL;

    .line 98
    invoke-virtual {p1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->c:Ljava/lang/String;

    return-void
.end method

.method public setUri(Ljava/net/URI;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iput-object p1, p0, Lanetwork/channel/entity/RequestImpl;->a:Ljava/net/URI;

    return-void
.end method
