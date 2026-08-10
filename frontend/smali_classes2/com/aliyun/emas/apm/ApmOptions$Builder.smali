.class public final Lcom/aliyun/emas/apm/ApmOptions$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/ApmOptions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private a:Landroid/app/Application;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field e:Ljava/util/List;

.field private f:Ljava/lang/String;

.field private g:Ljava/lang/String;

.field private h:Ljava/lang/String;

.field private i:I

.field private j:Ljava/util/List;

.field private k:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->e:Ljava/util/List;

    const/4 v0, 0x0

    iput v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->i:I

    .line 7
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->j:Ljava/util/List;

    iput-boolean v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->k:Z

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/ApmOptions;)V
    .locals 2

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->e:Ljava/util/List;

    const/4 v0, 0x0

    iput v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->i:I

    .line 15
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->j:Ljava/util/List;

    iput-boolean v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->k:Z

    .line 28
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->a(Lcom/aliyun/emas/apm/ApmOptions;)Landroid/app/Application;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    .line 29
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->b(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->b:Ljava/lang/String;

    .line 30
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->d(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->c:Ljava/lang/String;

    .line 31
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->e(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->d:Ljava/lang/String;

    .line 32
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->f(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->e:Ljava/util/List;

    .line 33
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->g(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->f:Ljava/lang/String;

    .line 34
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->h(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->g:Ljava/lang/String;

    .line 35
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->i(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->h:Ljava/lang/String;

    .line 36
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->j(Lcom/aliyun/emas/apm/ApmOptions;)I

    move-result v0

    iput v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->i:I

    .line 37
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->k(Lcom/aliyun/emas/apm/ApmOptions;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->j:Ljava/util/List;

    .line 38
    invoke-static {p1}, Lcom/aliyun/emas/apm/ApmOptions;->c(Lcom/aliyun/emas/apm/ApmOptions;)Z

    move-result p1

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->k:Z

    return-void
.end method


# virtual methods
.method public addComponent(Ljava/lang/Class;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "+",
            "Lcom/aliyun/emas/apm/BaseComponent;",
            ">;)",
            "Lcom/aliyun/emas/apm/ApmOptions$Builder;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->e:Ljava/util/List;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public addProductOptions(Lcom/aliyun/emas/apm/ApmProductOptions;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Lcom/aliyun/emas/apm/ApmProductOptions;",
            ">(TT;)",
            "Lcom/aliyun/emas/apm/ApmOptions$Builder;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->j:Ljava/util/List;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public build()Lcom/aliyun/emas/apm/ApmOptions;
    .locals 17

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->f:Ljava/lang/String;

    .line 1
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    const/16 v3, 0x80

    if-nez v1, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->f:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v3, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    .line 2
    invoke-static {v1}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_0

    iput-object v2, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->f:Ljava/lang/String;

    goto :goto_0

    .line 6
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "userId is longer than 128 char"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_1
    :goto_0
    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->g:Ljava/lang/String;

    .line 12
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->g:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v3, :cond_3

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    .line 13
    invoke-static {v1}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_2

    iput-object v2, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->g:Ljava/lang/String;

    goto :goto_1

    .line 17
    :cond_2
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "userNick is longer than 128 char"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_3
    :goto_1
    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->h:Ljava/lang/String;

    .line 23
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_5

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->h:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-le v1, v3, :cond_5

    iget-object v1, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    .line 24
    invoke-static {v1}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_4

    iput-object v2, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->h:Ljava/lang/String;

    goto :goto_2

    .line 28
    :cond_4
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "channel is longer than 128 char"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 34
    :cond_5
    :goto_2
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    iget-object v2, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->j:Ljava/util/List;

    .line 35
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_8

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/ApmProductOptions;

    .line 36
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-interface {v1, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    iget-object v4, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    .line 37
    invoke-static {v4}, Lcom/aliyun/emas/apm/util/CommonUtils;->isDebuggable(Landroid/content/Context;)Z

    move-result v4

    if-nez v4, :cond_6

    goto :goto_3

    .line 38
    :cond_6
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " added more than once"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 41
    :cond_7
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 45
    :cond_8
    new-instance v1, Lcom/aliyun/emas/apm/ApmOptions;

    iget-object v5, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    iget-object v6, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->b:Ljava/lang/String;

    iget-object v7, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->c:Ljava/lang/String;

    iget-object v8, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->d:Ljava/lang/String;

    iget-object v9, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->e:Ljava/util/List;

    iget-object v10, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->f:Ljava/lang/String;

    iget-object v11, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->g:Ljava/lang/String;

    iget-object v12, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->h:Ljava/lang/String;

    iget-boolean v13, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->k:Z

    iget-object v14, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->j:Ljava/util/List;

    iget v15, v0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->i:I

    const/16 v16, 0x0

    move-object v4, v1

    invoke-direct/range {v4 .. v16}, Lcom/aliyun/emas/apm/ApmOptions;-><init>(Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZLjava/util/List;ILcom/aliyun/emas/apm/ApmOptions$a;)V

    return-object v1
.end method

.method public openDebug(Z)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->k:Z

    return-object p0
.end method

.method public setAppKey(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 1

    const-string v0, "AppKey must be set."

    .line 1
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->b:Ljava/lang/String;

    return-object p0
.end method

.method public setAppRsaSecret(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 1

    const-string v0, "AppRsaSecret must be set."

    .line 1
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->d:Ljava/lang/String;

    return-object p0
.end method

.method public setAppSecret(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 1

    const-string v0, "AppSecret must be set."

    .line 1
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->c:Ljava/lang/String;

    return-object p0
.end method

.method public setApplication(Landroid/app/Application;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->a:Landroid/app/Application;

    return-object p0
.end method

.method public setChannel(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->h:Ljava/lang/String;

    return-object p0
.end method

.method public setNoCollectionDataType(I)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->i:I

    return-object p0
.end method

.method public setUserId(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->f:Ljava/lang/String;

    return-object p0
.end method

.method public setUserNick(Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmOptions$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmOptions$Builder;->g:Ljava/lang/String;

    return-object p0
.end method
