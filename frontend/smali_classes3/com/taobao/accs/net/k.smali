.class Lcom/taobao/accs/net/k;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/taobao/accs/net/j;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/j;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/k;->a:Lcom/taobao/accs/net/j;

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/net/k;->a:Lcom/taobao/accs/net/j;

    .line 80
    invoke-virtual {v0}, Lcom/taobao/accs/net/j;->o()V

    return-void
.end method
