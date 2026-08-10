.class public Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;
.super Ljava/lang/Object;


# instance fields
.field private a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/alibaba/sdk/android/logger/interceptor/c;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lcom/alibaba/sdk/android/logger/interceptor/a;

.field private d:Lcom/alibaba/sdk/android/logger/interceptor/b;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/logger/interceptor/a;Lcom/alibaba/sdk/android/logger/interceptor/b;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a:Ljava/util/ArrayList;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->b:Ljava/util/ArrayList;

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->c:Lcom/alibaba/sdk/android/logger/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->d:Lcom/alibaba/sdk/android/logger/interceptor/b;

    return-void
.end method


# virtual methods
.method public a()Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;
    .locals 3

    new-instance v0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;

    iget-object v1, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->c:Lcom/alibaba/sdk/android/logger/interceptor/a;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->d:Lcom/alibaba/sdk/android/logger/interceptor/b;

    invoke-direct {v0, v1, v2}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;-><init>(Lcom/alibaba/sdk/android/logger/interceptor/a;Lcom/alibaba/sdk/android/logger/interceptor/b;)V

    iget-object v1, v0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    iget-object v1, v0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->b:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->b:Ljava/util/ArrayList;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    return-object v0
.end method

.method public a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1

    const/4 v0, -0x1

    invoke-virtual {p0, v0, p1, p2, p3}, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->toNextLogInterceptor(ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/logger/interceptor/c;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->b:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public toNextLogInterceptor(ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 6

    add-int/lit8 v2, p1, 0x1

    iget-object p1, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-lt v2, p1, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->c:Lcom/alibaba/sdk/android/logger/interceptor/a;

    move-object v1, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/logger/interceptor/a;->handle(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->a:Ljava/util/ArrayList;

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    move-object v0, p1

    check-cast v0, Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;

    move-object v1, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-interface/range {v0 .. v5}, Lcom/alibaba/sdk/android/logger/interceptor/ILogInterceptor;->handle(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method public toNextLoggerInterceptor(ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    add-int/lit8 v2, p1, 0x1

    iget-object p1, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->b:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-lt v2, p1, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->d:Lcom/alibaba/sdk/android/logger/interceptor/b;

    move-object v1, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-virtual/range {v0 .. v5}, Lcom/alibaba/sdk/android/logger/interceptor/b;->a(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;->b:Ljava/util/ArrayList;

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    move-object v0, p1

    check-cast v0, Lcom/alibaba/sdk/android/logger/interceptor/c;

    move-object v1, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-interface/range {v0 .. v5}, Lcom/alibaba/sdk/android/logger/interceptor/c;->a(Lcom/alibaba/sdk/android/logger/interceptor/InterceptorManager;ILcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    return-void
.end method
