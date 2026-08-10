.class public Lcom/alibaba/sdk/android/emas/c;
.super Ljava/lang/Object;
.source "CacheManager.java"

# interfaces
.implements Lcom/alibaba/sdk/android/emas/Cache;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/alibaba/sdk/android/emas/Cache<",
        "Lcom/alibaba/sdk/android/emas/g;",
        ">;"
    }
.end annotation


# instance fields
.field private final a:I

.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/sdk/android/emas/g;",
            ">;"
        }
    .end annotation
.end field

.field private final b:I

.field private c:I

.field private final mSendManager:Lcom/alibaba/sdk/android/emas/j;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/emas/j;II)V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lcom/alibaba/sdk/android/emas/c;->a:I

    iput p3, p0, Lcom/alibaba/sdk/android/emas/c;->b:I

    const/4 p2, 0x0

    iput p2, p0, Lcom/alibaba/sdk/android/emas/c;->c:I

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/c;->mSendManager:Lcom/alibaba/sdk/android/emas/j;

    return-void
.end method

.method private b()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/c;->mSendManager:Lcom/alibaba/sdk/android/emas/j;

    iget-object v1, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    .line 50
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/emas/j;->a(Ljava/util/List;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/sdk/android/emas/c;->c:I

    return-void
.end method


# virtual methods
.method public a()Lcom/alibaba/sdk/android/emas/g;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public declared-synchronized a(Lcom/alibaba/sdk/android/emas/g;)V
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    if-nez v0, :cond_0

    .line 28
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    .line 30
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget v0, p0, Lcom/alibaba/sdk/android/emas/c;->c:I

    .line 32
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/emas/g;->length()I

    move-result p1

    add-int/2addr v0, p1

    iput v0, p0, Lcom/alibaba/sdk/android/emas/c;->c:I

    iget-object p1, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    .line 34
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    iget v0, p0, Lcom/alibaba/sdk/android/emas/c;->a:I

    if-ge p1, v0, :cond_1

    iget p1, p0, Lcom/alibaba/sdk/android/emas/c;->c:I

    iget v0, p0, Lcom/alibaba/sdk/android/emas/c;->b:I

    if-lt p1, v0, :cond_2

    .line 36
    :cond_1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/c;->b()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 38
    :cond_2
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public a(Lcom/alibaba/sdk/android/emas/g;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public synthetic add(Ljava/lang/Object;)V
    .locals 0

    .line 10
    check-cast p1, Lcom/alibaba/sdk/android/emas/g;

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/emas/c;->a(Lcom/alibaba/sdk/android/emas/g;)V

    return-void
.end method

.method public clear()V
    .locals 0

    return-void
.end method

.method public declared-synchronized flush()V
    .locals 1

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/c;->a:Ljava/util/List;

    if-eqz v0, :cond_1

    .line 41
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "CacheManager flush. immediately send."

    .line 45
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    .line 46
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/c;->b()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 47
    monitor-exit p0

    return-void

    .line 42
    :cond_1
    :goto_0
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public synthetic get()Ljava/lang/Object;
    .locals 1

    .line 10
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/emas/c;->a()Lcom/alibaba/sdk/android/emas/g;

    move-result-object v0

    return-object v0
.end method

.method public synthetic remove(Ljava/lang/Object;)Z
    .locals 0

    .line 10
    check-cast p1, Lcom/alibaba/sdk/android/emas/g;

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/emas/c;->a(Lcom/alibaba/sdk/android/emas/g;)Z

    move-result p1

    return p1
.end method
