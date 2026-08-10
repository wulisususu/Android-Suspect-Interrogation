.class Lcom/alibaba/sdk/android/push/e/a$a$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/e/a$a$1;->handleMessage(Landroid/os/Message;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Object;

.field final synthetic b:Lcom/alibaba/sdk/android/push/e/e;

.field final synthetic c:Lcom/alibaba/sdk/android/push/e/a$a$1;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/e/a$a$1;Ljava/lang/Object;Lcom/alibaba/sdk/android/push/e/e;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1$1;->c:Lcom/alibaba/sdk/android/push/e/a$a$1;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/e/a$a$1$1;->a:Ljava/lang/Object;

    iput-object p3, p0, Lcom/alibaba/sdk/android/push/e/a$a$1$1;->b:Lcom/alibaba/sdk/android/push/e/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$a$1$1;->c:Lcom/alibaba/sdk/android/push/e/a$a$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/e/a$a$1;->a:Lcom/alibaba/sdk/android/push/e/a$a;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/e/a$a;->c:Lcom/alibaba/sdk/android/push/e/c;

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/e/a$a$1$1;->a:Ljava/lang/Object;

    iget-object v2, p0, Lcom/alibaba/sdk/android/push/e/a$a$1$1;->b:Lcom/alibaba/sdk/android/push/e/e;

    invoke-interface {v0, v1, v2}, Lcom/alibaba/sdk/android/push/e/c;->a(Ljava/lang/Object;Lcom/alibaba/sdk/android/push/e/e;)V

    return-void
.end method
