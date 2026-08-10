.class public Lcom/alibaba/sdk/android/networkmonitor/a;
.super Ljava/lang/Object;
.source "MonitorData.java"


# instance fields
.field private a:I

.field private a:J

.field private a:Ljava/lang/String;

.field private a:Ljava/lang/Throwable;

.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/networkmonitor/e;",
            ">;"
        }
    .end annotation
.end field

.field private a:Z

.field private b:J

.field private b:Ljava/lang/String;

.field private c:J

.field private c:Ljava/lang/String;

.field private d:J

.field private d:Ljava/lang/String;

.field private e:J

.field private e:Ljava/lang/String;

.field private f:J

.field private f:Ljava/lang/String;

.field private g:J

.field private g:Ljava/lang/String;

.field private h:J

.field private h:Ljava/lang/String;

.field private i:J

.field private i:Ljava/lang/String;

.field private j:J

.field private k:J

.field private l:J

.field private m:J

.field private n:J

.field private o:J

.field private p:J

.field private q:J

.field private r:J

.field private s:J

.field private t:J

.field private u:J

.field private v:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->s:J

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->t:J

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->u:J

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->v:J

    .line 34
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->r:J

    .line 35
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/utils/d;->a()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/lang/String;

    return-void
.end method

.method public static a(Ljava/lang/Throwable;)Ljava/lang/String;
    .locals 2

    .line 24
    new-instance v0, Ljava/io/StringWriter;

    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V

    .line 25
    new-instance v1, Ljava/io/PrintWriter;

    invoke-direct {v1, v0}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V

    .line 28
    :try_start_0
    invoke-virtual {p0, v1}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 29
    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 31
    invoke-virtual {v1}, Ljava/io/PrintWriter;->close()V

    return-object p0

    :catchall_0
    move-exception p0

    invoke-virtual {v1}, Ljava/io/PrintWriter;->close()V

    .line 32
    throw p0
.end method

.method private a()Lorg/json/JSONArray;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 50
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/util/List;

    .line 51
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/networkmonitor/e;

    .line 52
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/networkmonitor/e;->a()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v0, v2}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method private a()Lorg/json/JSONObject;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 33
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:J

    const-string v3, "fetchStart"

    .line 34
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->b:J

    const-string v3, "domainLookupStart"

    .line 35
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:J

    const-string v3, "domainLookupEnd"

    .line 36
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->d:J

    const-string v3, "connectStart"

    .line 37
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->e:J

    const-string v3, "secureConnectionStart"

    .line 38
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->f:J

    const-string v3, "secureConnectionEnd"

    .line 39
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->g:J

    const-string v3, "connectEnd"

    .line 40
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->h:J

    const-string v3, "requestHeadersStart"

    .line 41
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->i:J

    const-string v3, "requestHeadersEnd"

    .line 42
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->j:J

    const-string v3, "requestBodyStart"

    .line 43
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->k:J

    const-string v3, "requestBodyEnd"

    .line 44
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->l:J

    const-string v3, "responseHeadersStart"

    .line 45
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->m:J

    const-string v3, "responseHeadersEnd"

    .line 46
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->n:J

    const-string v3, "responseBodyStart"

    .line 47
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->o:J

    const-string v3, "responseBodyEnd"

    .line 48
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->p:J

    const-string v3, "callEnd"

    .line 49
    invoke-virtual {v0, v3, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    return-object v0
.end method


# virtual methods
.method public a()J
    .locals 2

    iget-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-wide v0
.end method

.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:I

    return-void
.end method

.method public a(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->p:J

    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/networkmonitor/e;)V
    .locals 1

    if-eqz p1, :cond_2

    .line 15
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/networkmonitor/e;->a()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/util/List;

    if-nez v0, :cond_1

    .line 20
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/util/List;

    .line 23
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    :goto_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->i:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/lang/Throwable;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/lang/Throwable;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Z

    return v0
.end method

.method public a(Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:Ljava/lang/String;

    .line 2
    invoke-static {v0, p1}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->d:Ljava/lang/String;

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:Ljava/lang/String;

    const/4 p1, 0x1

    return p1
.end method

.method public b()J
    .locals 2

    iget-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->s:J

    return-wide v0
.end method

.method public b(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->g:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->b:Ljava/lang/String;

    return-void
.end method

.method public c(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->d:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->h:Ljava/lang/String;

    return-void
.end method

.method public d(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->g:Ljava/lang/String;

    return-void
.end method

.method public e(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->b:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->f:Ljava/lang/String;

    return-void
.end method

.method public f(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 4

    .line 3
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->t:J

    .line 4
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    array-length p1, p1

    int-to-long v2, p1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->t:J

    :cond_0
    return-void
.end method

.method public g(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->k:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 4

    .line 3
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->u:J

    .line 4
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    array-length p1, p1

    int-to-long v2, p1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->u:J

    :cond_0
    return-void
.end method

.method public h(J)V
    .locals 2

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-lez v0, :cond_0

    iget-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->s:J

    add-long/2addr v0, p1

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->s:J

    :cond_0
    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->e:Ljava/lang/String;

    return-void
.end method

.method public i(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->j:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:Ljava/lang/String;

    return-void
.end method

.method public j(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->i:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public k(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->h:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public l(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->o:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public m(J)V
    .locals 2

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-lez v0, :cond_0

    iget-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->v:J

    add-long/2addr v0, p1

    iput-wide v0, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->v:J

    :cond_0
    return-void
.end method

.method public n(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->n:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public o(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->m:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public p(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->l:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public q(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->f:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public r(J)V
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->e:J

    iput-wide p1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->q:J

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .line 1
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "traceId"

    :try_start_0
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/lang/String;

    .line 3
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "originIP"

    const-string v2, ""

    .line 5
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    const-string v1, "destinationIP"

    :try_start_1
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->b:Ljava/lang/String;

    .line 6
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0

    const-string v1, "url"

    :try_start_2
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->c:Ljava/lang/String;

    .line 7
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->d:Ljava/lang/String;

    .line 8
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_0

    if-nez v1, :cond_0

    const-string v1, "originUrl"

    :try_start_3
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->d:Ljava/lang/String;

    .line 9
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_3
    .catch Lorg/json/JSONException; {:try_start_3 .. :try_end_3} :catch_0

    :cond_0
    const-string v1, "networkLib"

    :try_start_4
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->g:Ljava/lang/String;

    .line 11
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_4
    .catch Lorg/json/JSONException; {:try_start_4 .. :try_end_4} :catch_0

    const-string v1, "httpCode"

    :try_start_5
    iget v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:I

    .line 12
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_5
    .catch Lorg/json/JSONException; {:try_start_5 .. :try_end_5} :catch_0

    const-string v1, "method"

    :try_start_6
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->h:Ljava/lang/String;

    .line 13
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "version"

    const-string v2, "1.0.0"

    .line 14
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "sdkVersion"

    const-string v2, "1.6.7"

    .line 15
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_6
    .catch Lorg/json/JSONException; {:try_start_6 .. :try_end_6} :catch_0

    const-string v1, "contentType"

    :try_start_7
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->i:Ljava/lang/String;

    .line 16
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_7
    .catch Lorg/json/JSONException; {:try_start_7 .. :try_end_7} :catch_0

    const-string v1, "networkProtocolName"

    :try_start_8
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->f:Ljava/lang/String;

    .line 17
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_8
    .catch Lorg/json/JSONException; {:try_start_8 .. :try_end_8} :catch_0

    const-string v1, "tlsVersion"

    :try_start_9
    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->e:Ljava/lang/String;

    .line 18
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_9
    .catch Lorg/json/JSONException; {:try_start_9 .. :try_end_9} :catch_0

    const-string v1, "upsize"

    :try_start_a
    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->s:J

    iget-wide v4, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->t:J

    add-long/2addr v2, v4

    .line 19
    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_a
    .catch Lorg/json/JSONException; {:try_start_a .. :try_end_a} :catch_0

    const-string v1, "downsize"

    :try_start_b
    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->v:J

    iget-wide v4, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->u:J

    add-long/2addr v2, v4

    .line 20
    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_b
    .catch Lorg/json/JSONException; {:try_start_b .. :try_end_b} :catch_0

    const-string v1, "time"

    :try_start_c
    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->r:J

    .line 21
    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_c
    .catch Lorg/json/JSONException; {:try_start_c .. :try_end_c} :catch_0

    const-string v1, "performance"

    .line 23
    :try_start_d
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/a;->a()Lorg/json/JSONObject;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/util/List;

    if-eqz v1, :cond_1

    .line 24
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1
    :try_end_d
    .catch Lorg/json/JSONException; {:try_start_d .. :try_end_d} :catch_0

    if-nez v1, :cond_1

    const-string v1, "events"

    .line 25
    :try_start_e
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/a;->a()Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/lang/Throwable;

    if-eqz v1, :cond_2

    .line 29
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    :try_end_e
    .catch Lorg/json/JSONException; {:try_start_e .. :try_end_e} :catch_0

    const-string v2, "stack"

    :try_start_f
    iget-object v3, p0, Lcom/alibaba/sdk/android/networkmonitor/a;->a:Ljava/lang/Throwable;

    .line 30
    invoke-static {v3}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "error"

    .line 31
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_f
    .catch Lorg/json/JSONException; {:try_start_f .. :try_end_f} :catch_0

    .line 37
    :catch_0
    :cond_2
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
