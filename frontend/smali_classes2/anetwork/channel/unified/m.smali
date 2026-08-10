.class Lanetwork/channel/unified/m;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanetwork/channel/unified/k;


# direct methods
.method constructor <init>(Lanetwork/channel/unified/k;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/unified/m;->a:Lanetwork/channel/unified/k;

    .line 139
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 143
    new-instance v0, Lanetwork/channel/unified/k$a;

    iget-object v1, p0, Lanetwork/channel/unified/m;->a:Lanetwork/channel/unified/k;

    iget-object v2, v1, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v2, v2, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v2}, Lanetwork/channel/entity/g;->a()Lanet/channel/request/Request;

    move-result-object v2

    iget-object v3, p0, Lanetwork/channel/unified/m;->a:Lanetwork/channel/unified/k;

    iget-object v3, v3, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v3, v3, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    const/4 v4, 0x0

    invoke-direct {v0, v1, v4, v2, v3}, Lanetwork/channel/unified/k$a;-><init>(Lanetwork/channel/unified/k;ILanet/channel/request/Request;Lanetwork/channel/interceptor/Callback;)V

    iget-object v1, p0, Lanetwork/channel/unified/m;->a:Lanetwork/channel/unified/k;

    iget-object v1, v1, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v1, v1, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    .line 144
    invoke-virtual {v1}, Lanetwork/channel/entity/g;->a()Lanet/channel/request/Request;

    move-result-object v1

    iget-object v2, p0, Lanetwork/channel/unified/m;->a:Lanetwork/channel/unified/k;

    iget-object v2, v2, Lanetwork/channel/unified/k;->a:Lanetwork/channel/unified/j;

    iget-object v2, v2, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    invoke-virtual {v0, v1, v2}, Lanetwork/channel/unified/k$a;->proceed(Lanet/channel/request/Request;Lanetwork/channel/interceptor/Callback;)Ljava/util/concurrent/Future;

    return-void
.end method
