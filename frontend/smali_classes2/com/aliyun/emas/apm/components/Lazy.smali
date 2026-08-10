.class public Lcom/aliyun/emas/apm/components/Lazy;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/inject/Provider;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Lcom/aliyun/emas/apm/inject/Provider<",
        "TT;>;"
    }
.end annotation


# static fields
.field public static final c:Ljava/lang/Object;


# instance fields
.field public volatile a:Ljava/lang/Object;

.field public volatile b:Lcom/aliyun/emas/apm/inject/Provider;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/components/Lazy;->c:Ljava/lang/Object;

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "TT;>;)V"
        }
    .end annotation

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/aliyun/emas/apm/components/Lazy;->c:Ljava/lang/Object;

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/Lazy;->a:Ljava/lang/Object;

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Lazy;->b:Lcom/aliyun/emas/apm/inject/Provider;

    return-void
.end method


# virtual methods
.method public get()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Lazy;->a:Ljava/lang/Object;

    sget-object v1, Lcom/aliyun/emas/apm/components/Lazy;->c:Ljava/lang/Object;

    if-ne v0, v1, :cond_1

    .line 3
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Lazy;->a:Ljava/lang/Object;

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Lazy;->b:Lcom/aliyun/emas/apm/inject/Provider;

    .line 6
    invoke-interface {v0}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/Lazy;->a:Ljava/lang/Object;

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/aliyun/emas/apm/components/Lazy;->b:Lcom/aliyun/emas/apm/inject/Provider;

    .line 12
    :cond_0
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_1
    :goto_0
    return-object v0
.end method
