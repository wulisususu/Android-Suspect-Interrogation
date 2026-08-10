.class Lcom/alibaba/sdk/android/settingservice/a/a$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/Set;

.field final synthetic b:Lcom/alibaba/sdk/android/settingservice/a/b;

.field final synthetic c:Lcom/alibaba/sdk/android/settingservice/a/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/settingservice/a/a;Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->a:Ljava/util/Set;

    iput-object p3, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->b:Lcom/alibaba/sdk/android/settingservice/a/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->e(Lcom/alibaba/sdk/android/settingservice/a/a;)Lcom/alibaba/sdk/android/settingservice/c/c;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Lcom/alibaba/sdk/android/settingservice/a/a;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->a:Ljava/util/Set;

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/settingservice/c/c;->a(Landroid/content/Context;Ljava/util/Set;)Ljava/util/Map;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Lcom/alibaba/sdk/android/settingservice/a/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->putAll(Ljava/util/Map;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->b(Lcom/alibaba/sdk/android/settingservice/a/a;)Lcom/alibaba/sdk/android/settingservice/c/a;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Lcom/alibaba/sdk/android/settingservice/a/a;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->c:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v2}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Lcom/alibaba/sdk/android/settingservice/a/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/settingservice/c/a;->a(Landroid/content/Context;Ljava/util/Map;)V

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a$2;->b:Lcom/alibaba/sdk/android/settingservice/a/b;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Lcom/alibaba/sdk/android/settingservice/a/b;->a()V

    :cond_1
    return-void
.end method
