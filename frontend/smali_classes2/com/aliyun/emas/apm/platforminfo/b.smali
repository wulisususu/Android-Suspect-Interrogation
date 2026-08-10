.class public Lcom/aliyun/emas/apm/platforminfo/b;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static volatile b:Lcom/aliyun/emas/apm/platforminfo/b;


# instance fields
.field private final a:Ljava/util/Set;


# direct methods
.method constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/platforminfo/b;->a:Ljava/util/Set;

    return-void
.end method

.method public static a()Lcom/aliyun/emas/apm/platforminfo/b;
    .locals 2

    sget-object v0, Lcom/aliyun/emas/apm/platforminfo/b;->b:Lcom/aliyun/emas/apm/platforminfo/b;

    if-nez v0, :cond_1

    const-class v1, Lcom/aliyun/emas/apm/platforminfo/b;

    .line 3
    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/aliyun/emas/apm/platforminfo/b;->b:Lcom/aliyun/emas/apm/platforminfo/b;

    if-nez v0, :cond_0

    .line 6
    new-instance v0, Lcom/aliyun/emas/apm/platforminfo/b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/platforminfo/b;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/platforminfo/b;->b:Lcom/aliyun/emas/apm/platforminfo/b;

    .line 8
    :cond_0
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_1
    :goto_0
    return-object v0
.end method


# virtual methods
.method b()Ljava/util/Set;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/platforminfo/b;->a:Ljava/util/Set;

    .line 1
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/platforminfo/b;->a:Ljava/util/Set;

    .line 2
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    .line 3
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
