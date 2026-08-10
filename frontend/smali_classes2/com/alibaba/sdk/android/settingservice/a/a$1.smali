.class Lcom/alibaba/sdk/android/settingservice/a/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/settingservice/a/a;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/settingservice/a/a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/settingservice/a/a;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->b(Lcom/alibaba/sdk/android/settingservice/a/a;)Lcom/alibaba/sdk/android/settingservice/c/a;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Lcom/alibaba/sdk/android/settingservice/a/a;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/settingservice/c/a;->a(Landroid/content/Context;)Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1, v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Lcom/alibaba/sdk/android/settingservice/a/a;Ljava/util/Map;)V

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->c(Lcom/alibaba/sdk/android/settingservice/a/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/concurrent/ConcurrentHashMap;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    invoke-static {v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->d(Lcom/alibaba/sdk/android/settingservice/a/a;)Ljava/util/Set;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->addAll(Ljava/util/Collection;)Z

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a$1;->a:Lcom/alibaba/sdk/android/settingservice/a/a;

    const/4 v2, 0x0

    const/4 v3, 0x1

    invoke-static {v1, v0, v2, v3}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Lcom/alibaba/sdk/android/settingservice/a/a;Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V

    return-void
.end method
