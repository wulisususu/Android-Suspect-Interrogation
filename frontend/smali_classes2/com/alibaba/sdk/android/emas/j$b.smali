.class Lcom/alibaba/sdk/android/emas/j$b;
.super Ljava/lang/Object;
.source "SendManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/emas/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field private final a:Lcom/alibaba/sdk/android/emas/f;

.field final synthetic a:Lcom/alibaba/sdk/android/emas/j;

.field private final d:Z

.field private final f:I


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/emas/j;Lcom/alibaba/sdk/android/emas/f;ZI)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 140
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    iput-boolean p3, p0, Lcom/alibaba/sdk/android/emas/j$b;->d:Z

    iput p4, p0, Lcom/alibaba/sdk/android/emas/j$b;->f:I

    return-void
.end method

.method private a(Ljava/util/List;)Ljava/util/Map;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 272
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 274
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/emas/g;

    .line 275
    iget-object v2, v1, Lcom/alibaba/sdk/android/emas/g;->i:Ljava/lang/String;

    invoke-interface {v0, v2}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/StringBuilder;

    if-nez v2, :cond_0

    .line 277
    new-instance v2, Ljava/lang/StringBuilder;

    iget-object v3, v1, Lcom/alibaba/sdk/android/emas/g;->h:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 278
    iget-object v1, v1, Lcom/alibaba/sdk/android/emas/g;->i:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_0
    const/4 v3, 0x1

    .line 280
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v1, v1, Lcom/alibaba/sdk/android/emas/g;->h:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 284
    :cond_1
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    .line 285
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 286
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_2
    return-object p1
.end method

.method private a()Z
    .locals 3

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->d:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 224
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/EmasSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->isBackground()Z

    move-result v0

    if-eqz v0, :cond_0

    return v1

    .line 228
    :cond_0
    invoke-static {}, Lcom/alibaba/sdk/android/emas/j;->a()Ljava/util/concurrent/ThreadPoolExecutor;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->size()I

    move-result v0

    iget v2, p0, Lcom/alibaba/sdk/android/emas/j$b;->f:I

    if-gt v0, v2, :cond_1

    const/4 v1, 0x1

    :cond_1
    return v1
.end method

.method private b()Z
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    .line 232
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/f;->a()Lcom/alibaba/sdk/android/emas/d;

    move-result-object v0

    sget-object v1, Lcom/alibaba/sdk/android/emas/d;->b:Lcom/alibaba/sdk/android/emas/d;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private d(Lcom/alibaba/sdk/android/emas/f;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 197
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 201
    :cond_0
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/emas/f;->a()Lcom/alibaba/sdk/android/emas/d;

    move-result-object v0

    sget-object v1, Lcom/alibaba/sdk/android/emas/d;->b:Lcom/alibaba/sdk/android/emas/d;

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 203
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/emas/e;->a(Lcom/alibaba/sdk/android/emas/f;)Z

    .line 207
    :cond_1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/j$b;->a()Z

    move-result p1

    if-eqz p1, :cond_3

    const-string p1, "SendManager removeAndSendNextDiskCache ==> trying send disk cache."

    .line 208
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 210
    invoke-static {p1}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/emas/e;->a()Lcom/alibaba/sdk/android/emas/f;

    move-result-object p1

    if-eqz p1, :cond_2

    const-string v0, "SendManager sending disk cache."

    .line 212
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 213
    invoke-static {v0, p1}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;Lcom/alibaba/sdk/android/emas/f;)V

    goto :goto_0

    :cond_2
    const-string p1, "SendManager disk cache is empty."

    .line 215
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 218
    :cond_3
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "SendManager finish send. background: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/EmasSender;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->isBackground()Z

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ", queue size: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Lcom/alibaba/sdk/android/emas/j;->a()Ljava/util/concurrent/ThreadPoolExecutor;

    move-result-object v0

    .line 219
    invoke-virtual {v0}, Ljava/util/concurrent/ThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/concurrent/BlockingQueue;->size()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ", limit: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->f:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 218
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public b()Lcom/alibaba/sdk/android/emas/f;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    return-object v0
.end method

.method public f()V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 240
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 241
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/j$b;->b()Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "SendManager send queue fill, write into disk cache."

    .line 243
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    .line 245
    new-instance v0, Lcom/alibaba/sdk/android/emas/j$b$1;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/emas/j$b$1;-><init>(Lcom/alibaba/sdk/android/emas/j$b;)V

    .line 252
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    if-ne v1, v2, :cond_0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 254
    invoke-static {v1}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Ljava/util/concurrent/ExecutorService;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    const-string v0, "SendManager writeIntoDiskCache error"

    .line 256
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    goto :goto_0

    .line 260
    :cond_0
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    :cond_1
    const-string v0, "SendManager send queue fill, already in disk cache. do nothing."

    .line 264
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    const-string v0, "SendManager send queue fill, disk cache not open, discard."

    .line 267
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    .line 148
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/f;->a()Lcom/alibaba/sdk/android/emas/d;

    move-result-object v0

    sget-object v1, Lcom/alibaba/sdk/android/emas/d;->b:Lcom/alibaba/sdk/android/emas/d;

    if-ne v0, v1, :cond_0

    .line 149
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "SendManager send disk log, location:"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/emas/f;->getLocation()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 153
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/PreSendHandler;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 154
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/PreSendHandler;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/emas/f;->a()Ljava/util/List;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/emas/f;->a()Lcom/alibaba/sdk/android/emas/d;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/alibaba/sdk/android/emas/PreSendHandler;->onHandlePreSend(Ljava/util/List;Lcom/alibaba/sdk/android/emas/d;)Ljava/util/List;

    move-result-object v0

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    .line 156
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/f;->a()Ljava/util/List;

    move-result-object v0

    :goto_0
    if-eqz v0, :cond_6

    .line 159
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_6

    .line 161
    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/emas/j$b;->a(Ljava/util/List;)Ljava/util/Map;

    move-result-object v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 165
    invoke-static {v1}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    iget-object v2, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    invoke-static {v2}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v2

    invoke-static {v1, v2, v0}, Lcom/alibaba/sdk/android/tbrest/request/BizRequest;->getPackRequest(Landroid/content/Context;Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/util/Map;)[B

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v1, "SendManager pack request failed"

    .line 167
    invoke-static {v1, v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 168
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 169
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/e;->b(Lcom/alibaba/sdk/android/emas/f;)V

    :cond_2
    const/4 v0, 0x0

    :goto_1
    if-eqz v0, :cond_5

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 174
    invoke-static {v1}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    invoke-static {v2}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v2

    iget-object v2, v2, Lcom/alibaba/sdk/android/tbrest/SendService;->host:Ljava/lang/String;

    invoke-static {v1, v2, v0}, Lcom/alibaba/sdk/android/tbrest/request/UrlWrapper;->sendRequest(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;[B)Lcom/alibaba/sdk/android/tbrest/request/BizResponse;

    move-result-object v0

    .line 175
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/tbrest/request/BizResponse;->isSuccess()Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "SendManager SendTask ==> bizResponse isSuccess"

    .line 176
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    .line 177
    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/emas/j$b;->d(Lcom/alibaba/sdk/android/emas/f;)V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 179
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    if-eqz v0, :cond_4

    const-string v0, "SendManager SendTask ==> request failed. put into cache."

    .line 180
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/j;

    .line 181
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/j;->a(Lcom/alibaba/sdk/android/emas/j;)Lcom/alibaba/sdk/android/emas/e;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/e;->a(Lcom/alibaba/sdk/android/emas/f;)V

    goto :goto_2

    :cond_4
    const-string v0, "SendManager SendTask ==> request failed. do nothing."

    .line 183
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    goto :goto_2

    :cond_5
    const-string v0, "SendManager pack request is null."

    .line 187
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    .line 188
    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/emas/j$b;->d(Lcom/alibaba/sdk/android/emas/f;)V

    goto :goto_2

    :cond_6
    const-string v0, "SendManager direct removeAndSendNextDiskCache"

    .line 191
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/j$b;->a:Lcom/alibaba/sdk/android/emas/f;

    .line 192
    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/emas/j$b;->d(Lcom/alibaba/sdk/android/emas/f;)V

    :goto_2
    return-void
.end method
