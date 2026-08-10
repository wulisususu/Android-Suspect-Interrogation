.class Lcom/alibaba/sdk/android/push/a/b$23;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/push/CommonCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/b;->a(Landroid/content/Context;Lcom/alibaba/sdk/android/push/CommonCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/CommonCallback;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lcom/alibaba/sdk/android/push/a/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/b;Lcom/alibaba/sdk/android/push/CommonCallback;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$23;->c:Lcom/alibaba/sdk/android/push/a/b;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/a/b$23;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    iput-object p3, p0, Lcom/alibaba/sdk/android/push/a/b$23;->b:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$23;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-interface {v0, p1, p2}, Lcom/alibaba/sdk/android/push/CommonCallback;->onFailed(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$23;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/push/CommonCallback;->onSuccess(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$23;->c:Lcom/alibaba/sdk/android/push/a/b;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;)Lcom/alibaba/sdk/android/push/a/a;

    move-result-object p1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$23;->b:Landroid/content/Context;

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/push/a/a;->b(Landroid/content/Context;)V

    return-void
.end method
