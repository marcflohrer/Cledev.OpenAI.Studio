using Microsoft.EntityFrameworkCore;

namespace Cledev.OpenAI.Studio.Database;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions options) : base(options) { }
}
