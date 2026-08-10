.class public Lanet/channel/request/Request;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/request/Request$Builder;,
        Lanet/channel/request/Request$Method;
    }
.end annotation


# static fields
.field public static final DEFAULT_CHARSET:Ljava/lang/String; = "UTF-8"


# instance fields
.field public final a:Lanet/channel/statist/RequestStatistic;

.field private b:Lanet/channel/util/HttpUrl;

.field private c:Lanet/channel/util/HttpUrl;

.field private d:Lanet/channel/util/HttpUrl;

.field private e:Ljava/net/URL;

.field private f:Ljava/lang/String;

.field private g:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private h:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private i:Ljava/lang/String;

.field private j:Lanet/channel/request/BodyEntry;

.field private k:Z

.field private l:Ljava/lang/String;

.field private m:Ljava/lang/String;

.field private n:I

.field private o:I

.field private p:I

.field private q:Ljavax/net/ssl/HostnameVerifier;

.field private r:Ljavax/net/ssl/SSLSocketFactory;

.field private s:Z


# direct methods
.method private constructor <init>(Lanet/channel/request/Request$Builder;)V
    .locals 3

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "GET"

    iput-object v0, p0, Lanet/channel/request/Request;->f:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/request/Request;->k:Z

    const/4 v0, 0x0

    iput v0, p0, Lanet/channel/request/Request;->n:I

    const/16 v0, 0x2710

    iput v0, p0, Lanet/channel/request/Request;->o:I

    iput v0, p0, Lanet/channel/request/Request;->p:I

    .line 74
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->f:Ljava/lang/String;

    .line 75
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->b(Lanet/channel/request/Request$Builder;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->g:Ljava/util/Map;

    .line 76
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->c(Lanet/channel/request/Request$Builder;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->h:Ljava/util/Map;

    .line 77
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->d(Lanet/channel/request/Request$Builder;)Lanet/channel/request/BodyEntry;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    .line 78
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->e(Lanet/channel/request/Request$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->i:Ljava/lang/String;

    .line 79
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->f(Lanet/channel/request/Request$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lanet/channel/request/Request;->k:Z

    .line 80
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->g(Lanet/channel/request/Request$Builder;)I

    move-result v0

    iput v0, p0, Lanet/channel/request/Request;->n:I

    .line 81
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->h(Lanet/channel/request/Request$Builder;)Ljavax/net/ssl/HostnameVerifier;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->q:Ljavax/net/ssl/HostnameVerifier;

    .line 82
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->i(Lanet/channel/request/Request$Builder;)Ljavax/net/ssl/SSLSocketFactory;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->r:Ljavax/net/ssl/SSLSocketFactory;

    .line 83
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->j(Lanet/channel/request/Request$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->l:Ljava/lang/String;

    .line 84
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->k(Lanet/channel/request/Request$Builder;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->m:Ljava/lang/String;

    .line 85
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->l(Lanet/channel/request/Request$Builder;)I

    move-result v0

    iput v0, p0, Lanet/channel/request/Request;->o:I

    .line 86
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->m(Lanet/channel/request/Request$Builder;)I

    move-result v0

    iput v0, p0, Lanet/channel/request/Request;->p:I

    .line 87
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->n(Lanet/channel/request/Request$Builder;)Lanet/channel/util/HttpUrl;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->b:Lanet/channel/util/HttpUrl;

    .line 88
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->o(Lanet/channel/request/Request$Builder;)Lanet/channel/util/HttpUrl;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    if-nez v0, :cond_0

    .line 90
    invoke-direct {p0}, Lanet/channel/request/Request;->b()V

    .line 92
    :cond_0
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->p(Lanet/channel/request/Request$Builder;)Lanet/channel/statist/RequestStatistic;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {p1}, Lanet/channel/request/Request$Builder;->p(Lanet/channel/request/Request$Builder;)Lanet/channel/statist/RequestStatistic;

    move-result-object v0

    goto :goto_0

    :cond_1
    new-instance v0, Lanet/channel/statist/RequestStatistic;

    invoke-virtual {p0}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lanet/channel/request/Request;->l:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lanet/channel/statist/RequestStatistic;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    iput-object v0, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    .line 93
    invoke-static {p1}, Lanet/channel/request/Request$Builder;->q(Lanet/channel/request/Request$Builder;)Z

    move-result p1

    iput-boolean p1, p0, Lanet/channel/request/Request;->s:Z

    return-void
.end method

.method synthetic constructor <init>(Lanet/channel/request/Request$Builder;Lanet/channel/request/Request$1;)V
    .locals 0

    .line 28
    invoke-direct {p0, p1}, Lanet/channel/request/Request;-><init>(Lanet/channel/request/Request$Builder;)V

    return-void
.end method

.method private a()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 119
    invoke-static {}, Lanet/channel/AwcnConfig;->isCookieHeaderRedundantFix()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 120
    new-instance v0, Ljava/util/HashMap;

    iget-object v1, p0, Lanet/channel/request/Request;->g:Ljava/util/Map;

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    return-object v0

    :cond_0
    iget-object v0, p0, Lanet/channel/request/Request;->g:Ljava/util/Map;

    return-object v0
.end method

.method private b()V
    .locals 5

    const-string v0, "application/x-www-form-urlencoded; charset="

    iget-object v1, p0, Lanet/channel/request/Request;->h:Ljava/util/Map;

    .line 245
    invoke-virtual {p0}, Lanet/channel/request/Request;->getContentEncoding()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lanet/channel/strategy/utils/c;->a(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 246
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4

    iget-object v2, p0, Lanet/channel/request/Request;->f:Ljava/lang/String;

    .line 247
    invoke-static {v2}, Lanet/channel/request/Request$Method;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    if-eqz v2, :cond_0

    goto :goto_0

    .line 262
    :cond_0
    :try_start_0
    new-instance v2, Lanet/channel/request/ByteArrayEntry;

    invoke-virtual {p0}, Lanet/channel/request/Request;->getContentEncoding()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    invoke-direct {v2, v1}, Lanet/channel/request/ByteArrayEntry;-><init>([B)V

    iput-object v2, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    iget-object v1, p0, Lanet/channel/request/Request;->g:Ljava/util/Map;

    const-string v2, "Content-Type"

    .line 263
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lanet/channel/request/Request;->getContentEncoding()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :cond_1
    :goto_0
    iget-object v0, p0, Lanet/channel/request/Request;->b:Lanet/channel/util/HttpUrl;

    .line 248
    invoke-virtual {v0}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object v0

    .line 249
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, "?"

    .line 250
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->indexOf(Ljava/lang/String;)I

    move-result v3

    const/4 v4, -0x1

    if-ne v3, v4, :cond_2

    const/16 v0, 0x3f

    .line 251
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 252
    :cond_2
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v3, 0x26

    if-eq v0, v3, :cond_3

    .line 253
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 255
    :cond_3
    :goto_1
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 256
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v0

    if-eqz v0, :cond_4

    iput-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    :catch_0
    :cond_4
    :goto_2
    iget-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    if-nez v0, :cond_5

    iget-object v0, p0, Lanet/channel/request/Request;->b:Lanet/channel/util/HttpUrl;

    iput-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    :cond_5
    return-void
.end method


# virtual methods
.method public containsBody()Z
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public getBizId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->l:Ljava/lang/String;

    return-object v0
.end method

.method public getBodyBytes()[B
    .locals 2

    iget-object v0, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    if-eqz v0, :cond_0

    .line 210
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    const/16 v1, 0x80

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 212
    :try_start_0
    invoke-virtual {p0, v0}, Lanet/channel/request/Request;->postBody(Ljava/io/OutputStream;)I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 215
    :catch_0
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getConnectTimeout()I
    .locals 1

    iget v0, p0, Lanet/channel/request/Request;->o:I

    return v0
.end method

.method public getContentEncoding()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->i:Ljava/lang/String;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "UTF-8"

    :goto_0
    return-object v0
.end method

.method public getHeaders()Ljava/util/Map;
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

    iget-object v0, p0, Lanet/channel/request/Request;->g:Ljava/util/Map;

    .line 181
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getHost()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    .line 173
    invoke-virtual {v0}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getHostnameVerifier()Ljavax/net/ssl/HostnameVerifier;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->q:Ljavax/net/ssl/HostnameVerifier;

    return-object v0
.end method

.method public getHttpUrl()Lanet/channel/util/HttpUrl;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    return-object v0
.end method

.method public getMethod()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->f:Ljava/lang/String;

    return-object v0
.end method

.method public getReadTimeout()I
    .locals 1

    iget v0, p0, Lanet/channel/request/Request;->p:I

    return v0
.end method

.method public getRedirectTimes()I
    .locals 1

    iget v0, p0, Lanet/channel/request/Request;->n:I

    return v0
.end method

.method public getSeq()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->m:Ljava/lang/String;

    return-object v0
.end method

.method public getSslSocketFactory()Ljavax/net/ssl/SSLSocketFactory;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->r:Ljavax/net/ssl/SSLSocketFactory;

    return-object v0
.end method

.method public getUrl()Ljava/net/URL;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->e:Ljava/net/URL;

    if-nez v0, :cond_1

    iget-object v0, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    .line 135
    :goto_0
    invoke-virtual {v0}, Lanet/channel/util/HttpUrl;->toURL()Ljava/net/URL;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/request/Request;->e:Ljava/net/URL;

    :cond_1
    iget-object v0, p0, Lanet/channel/request/Request;->e:Ljava/net/URL;

    return-object v0
.end method

.method public getUrlString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    .line 130
    invoke-virtual {v0}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public isAllowRequestInBg()Z
    .locals 1

    iget-boolean v0, p0, Lanet/channel/request/Request;->s:Z

    return v0
.end method

.method public isRedirectEnable()Z
    .locals 1

    iget-boolean v0, p0, Lanet/channel/request/Request;->k:Z

    return v0
.end method

.method public newBuilder()Lanet/channel/request/Request$Builder;
    .locals 2

    .line 97
    new-instance v0, Lanet/channel/request/Request$Builder;

    invoke-direct {v0}, Lanet/channel/request/Request$Builder;-><init>()V

    iget-object v1, p0, Lanet/channel/request/Request;->f:Ljava/lang/String;

    .line 98
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Ljava/lang/String;)Ljava/lang/String;

    .line 99
    invoke-direct {p0}, Lanet/channel/request/Request;->a()Ljava/util/Map;

    move-result-object v1

    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Ljava/util/Map;)Ljava/util/Map;

    iget-object v1, p0, Lanet/channel/request/Request;->h:Ljava/util/Map;

    .line 100
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->b(Lanet/channel/request/Request$Builder;Ljava/util/Map;)Ljava/util/Map;

    iget-object v1, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    .line 101
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Lanet/channel/request/BodyEntry;)Lanet/channel/request/BodyEntry;

    iget-object v1, p0, Lanet/channel/request/Request;->i:Ljava/lang/String;

    .line 102
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->b(Lanet/channel/request/Request$Builder;Ljava/lang/String;)Ljava/lang/String;

    iget-boolean v1, p0, Lanet/channel/request/Request;->k:Z

    .line 103
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Z)Z

    iget v1, p0, Lanet/channel/request/Request;->n:I

    .line 104
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;I)I

    iget-object v1, p0, Lanet/channel/request/Request;->q:Ljavax/net/ssl/HostnameVerifier;

    .line 105
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Ljavax/net/ssl/HostnameVerifier;)Ljavax/net/ssl/HostnameVerifier;

    iget-object v1, p0, Lanet/channel/request/Request;->r:Ljavax/net/ssl/SSLSocketFactory;

    .line 106
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Ljavax/net/ssl/SSLSocketFactory;)Ljavax/net/ssl/SSLSocketFactory;

    iget-object v1, p0, Lanet/channel/request/Request;->b:Lanet/channel/util/HttpUrl;

    .line 107
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Lanet/channel/util/HttpUrl;)Lanet/channel/util/HttpUrl;

    iget-object v1, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    .line 108
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->b(Lanet/channel/request/Request$Builder;Lanet/channel/util/HttpUrl;)Lanet/channel/util/HttpUrl;

    iget-object v1, p0, Lanet/channel/request/Request;->l:Ljava/lang/String;

    .line 109
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->c(Lanet/channel/request/Request$Builder;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/request/Request;->m:Ljava/lang/String;

    .line 110
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->d(Lanet/channel/request/Request$Builder;Ljava/lang/String;)Ljava/lang/String;

    iget v1, p0, Lanet/channel/request/Request;->o:I

    .line 111
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->b(Lanet/channel/request/Request$Builder;I)I

    iget v1, p0, Lanet/channel/request/Request;->p:I

    .line 112
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->c(Lanet/channel/request/Request$Builder;I)I

    iget-object v1, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    .line 113
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->a(Lanet/channel/request/Request$Builder;Lanet/channel/statist/RequestStatistic;)Lanet/channel/statist/RequestStatistic;

    iget-boolean v1, p0, Lanet/channel/request/Request;->s:Z

    .line 114
    invoke-static {v0, v1}, Lanet/channel/request/Request$Builder;->b(Lanet/channel/request/Request$Builder;Z)Z

    return-object v0
.end method

.method public postBody(Ljava/io/OutputStream;)I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    iget-object v0, p0, Lanet/channel/request/Request;->j:Lanet/channel/request/BodyEntry;

    if-eqz v0, :cond_0

    .line 203
    invoke-interface {v0, p1}, Lanet/channel/request/BodyEntry;->writeTo(Ljava/io/OutputStream;)I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method

.method public setDnsOptimize(Ljava/lang/String;I)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iget-object v1, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    if-nez v1, :cond_0

    .line 147
    new-instance v1, Lanet/channel/util/HttpUrl;

    iget-object v2, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    invoke-direct {v1, v2}, Lanet/channel/util/HttpUrl;-><init>(Lanet/channel/util/HttpUrl;)V

    iput-object v1, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    :cond_0
    iget-object v1, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    .line 149
    invoke-virtual {v1, p1, p2}, Lanet/channel/util/HttpUrl;->replaceIpAndPort(Ljava/lang/String;I)V

    goto :goto_0

    :cond_1
    iput-object v0, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    :goto_0
    iput-object v0, p0, Lanet/channel/request/Request;->e:Ljava/net/URL;

    iget-object v0, p0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    .line 154
    invoke-virtual {v0, p1, p2}, Lanet/channel/statist/RequestStatistic;->setIPAndPort(Ljava/lang/String;I)V

    return-void
.end method

.method public setUrlScheme(Z)V
    .locals 2

    iget-object v0, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    if-nez v0, :cond_0

    .line 162
    new-instance v0, Lanet/channel/util/HttpUrl;

    iget-object v1, p0, Lanet/channel/request/Request;->c:Lanet/channel/util/HttpUrl;

    invoke-direct {v0, v1}, Lanet/channel/util/HttpUrl;-><init>(Lanet/channel/util/HttpUrl;)V

    iput-object v0, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    :cond_0
    iget-object v0, p0, Lanet/channel/request/Request;->d:Lanet/channel/util/HttpUrl;

    if-eqz p1, :cond_1

    const-string p1, "https"

    goto :goto_0

    :cond_1
    const-string p1, "http"

    .line 164
    :goto_0
    invoke-virtual {v0, p1}, Lanet/channel/util/HttpUrl;->setScheme(Ljava/lang/String;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lanet/channel/request/Request;->e:Ljava/net/URL;

    return-void
.end method
