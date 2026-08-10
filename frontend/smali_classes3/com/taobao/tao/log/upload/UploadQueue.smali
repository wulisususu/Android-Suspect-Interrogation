.class public Lcom/taobao/tao/log/upload/UploadQueue;
.super Ljava/lang/Object;
.source "UploadQueue.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/upload/UploadQueue$CreateInstance;
    }
.end annotation


# instance fields
.field private TAG:Ljava/lang/String;

.field private fileUploadListenerMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/tao/log/upload/FileUploadListener;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.UploadQueue"

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploadQueue;->TAG:Ljava/lang/String;

    .line 18
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploadQueue;->fileUploadListenerMap:Ljava/util/Map;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/upload/UploadQueue$1;)V
    .locals 0

    .line 13
    invoke-direct {p0}, Lcom/taobao/tao/log/upload/UploadQueue;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/taobao/tao/log/upload/UploadQueue;
    .locals 2

    const-class v0, Lcom/taobao/tao/log/upload/UploadQueue;

    monitor-enter v0

    .line 31
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/upload/UploadQueue$CreateInstance;->access$100()Lcom/taobao/tao/log/upload/UploadQueue;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public popListener(Ljava/lang/String;)Lcom/taobao/tao/log/upload/FileUploadListener;
    .locals 2

    iget-object v0, p0, Lcom/taobao/tao/log/upload/UploadQueue;->fileUploadListenerMap:Ljava/util/Map;

    .line 51
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/tao/log/upload/FileUploadListener;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/taobao/tao/log/upload/UploadQueue;->fileUploadListenerMap:Ljava/util/Map;

    .line 54
    invoke-interface {v1, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public pushListener(Ljava/lang/String;Lcom/taobao/tao/log/upload/FileUploadListener;)V
    .locals 1

    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    iget-object v0, p0, Lcom/taobao/tao/log/upload/UploadQueue;->fileUploadListenerMap:Ljava/util/Map;

    .line 41
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-void
.end method
