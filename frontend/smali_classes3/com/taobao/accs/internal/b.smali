.class Lcom/taobao/accs/internal/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/taobao/accs/ConnectionListener;


# instance fields
.field final synthetic a:Lcom/taobao/accs/internal/a;


# direct methods
.method constructor <init>(Lcom/taobao/accs/internal/a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    .line 70
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onConnect()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    .line 73
    iget-object v0, v0, Lcom/taobao/accs/internal/a;->c:Lcom/taobao/accs/internal/ACCSManagerImpl;

    iget-object v0, v0, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    invoke-virtual {v0}, Lcom/taobao/accs/net/b;->j()Lcom/taobao/accs/client/c;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    iget-object v1, v1, Lcom/taobao/accs/internal/a;->b:Landroid/content/Context;

    .line 74
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    .line 73
    invoke-virtual {v0, v1}, Lcom/taobao/accs/client/c;->e(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    iget-object v0, v0, Lcom/taobao/accs/internal/a;->c:Lcom/taobao/accs/internal/ACCSManagerImpl;

    .line 74
    invoke-static {v0}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Lcom/taobao/accs/internal/ACCSManagerImpl;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    .line 76
    iget-object v0, v0, Lcom/taobao/accs/internal/a;->c:Lcom/taobao/accs/internal/ACCSManagerImpl;

    iget-object v1, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    iget-object v1, v1, Lcom/taobao/accs/internal/a;->b:Landroid/content/Context;

    iget-object v2, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    iget-object v2, v2, Lcom/taobao/accs/internal/a;->c:Lcom/taobao/accs/internal/ACCSManagerImpl;

    iget-object v2, v2, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    iget-object v2, v2, Lcom/taobao/accs/net/b;->b:Ljava/lang/String;

    iget-object v3, p0, Lcom/taobao/accs/internal/b;->a:Lcom/taobao/accs/internal/a;

    iget-object v3, v3, Lcom/taobao/accs/internal/a;->c:Lcom/taobao/accs/internal/ACCSManagerImpl;

    iget-object v3, v3, Lcom/taobao/accs/internal/ACCSManagerImpl;->a:Lcom/taobao/accs/net/b;

    iget-object v3, v3, Lcom/taobao/accs/net/b;->a:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3}, Lcom/taobao/accs/internal/ACCSManagerImpl;->a(Lcom/taobao/accs/internal/ACCSManagerImpl;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onDisconnect(ILjava/lang/String;)V
    .locals 0

    return-void
.end method
