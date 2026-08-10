.class Lanetwork/channel/unified/j;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field public final a:Lanetwork/channel/entity/g;

.field public b:Lanetwork/channel/interceptor/Callback;

.field public final c:Ljava/lang/String;

.field public volatile d:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public volatile e:Lanetwork/channel/unified/IUnifiedTask;

.field public volatile f:Ljava/util/concurrent/Future;


# direct methods
.method public constructor <init>(Lanetwork/channel/entity/g;Lanetwork/channel/interceptor/Callback;)V
    .locals 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 20
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object v0, p0, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    iput-object v0, p0, Lanetwork/channel/unified/j;->f:Ljava/util/concurrent/Future;

    iput-object p1, p0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    .line 26
    iget-object p1, p1, Lanetwork/channel/entity/g;->e:Ljava/lang/String;

    iput-object p1, p0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    iput-object p2, p0, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lanetwork/channel/unified/j;->f:Ljava/util/concurrent/Future;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    .line 33
    invoke-interface {v0, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/unified/j;->f:Ljava/util/concurrent/Future;

    :cond_0
    return-void
.end method

.method public b()V
    .locals 1

    iget-object v0, p0, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    .line 40
    invoke-interface {v0}, Lanetwork/channel/unified/IUnifiedTask;->cancel()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    :cond_0
    return-void
.end method
