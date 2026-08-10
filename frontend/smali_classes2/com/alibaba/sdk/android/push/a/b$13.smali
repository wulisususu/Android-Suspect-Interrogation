.class Lcom/alibaba/sdk/android/push/a/b$13;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/b;->clearNotifications()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/a/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/b;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$13;->a:Lcom/alibaba/sdk/android/push/a/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$13;->a:Lcom/alibaba/sdk/android/push/a/b;

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;)Lcom/alibaba/sdk/android/push/a/a;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/push/a/a;->b()V

    return-void
.end method
